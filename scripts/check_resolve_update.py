"""Read-only GitHub/repo preflight. Never installs code or launches Resolve."""
import argparse
from datetime import datetime, timezone
import json
from pathlib import Path
import re
import subprocess
import urllib.request

URL = 'https://api.github.com/repos/samuelgursky/davinci-resolve-mcp/releases/latest'
REMOTE = 'https://github.com/samuelgursky/davinci-resolve-mcp.git'

def git(repo, *args):
    p = subprocess.run(['git', '-C', str(repo), *args], capture_output=True, text=True, timeout=20)
    if p.returncode: raise RuntimeError('git ' + args[0] + ' failed')
    return p.stdout.strip()

def check(repo):
    out = {'checked_at':datetime.now(timezone.utc).isoformat(), 'repo':str(repo), 'status':'check_failed', 'installs_updates':False}
    try:
        out['local_commit'] = git(repo,'rev-parse','HEAD')
        out['local_changes'] = bool(git(repo,'status','--porcelain'))
        readme = (repo/'README.md').read_text(encoding='utf-8')
        match = re.search(r'badge/version-([0-9.]+)-', readme)
        out['local_version'] = match.group(1) if match else None
        req=urllib.request.Request(URL,headers={'User-Agent':'HiddenChapters-Playbook-UpdateCheck','Accept':'application/vnd.github+json'})
        with urllib.request.urlopen(req,timeout=15) as response: release=json.load(response)
        out.update(latest_version=release['tag_name'].lstrip('v'), release_url=release['html_url'], release_published_at=release['published_at'], release_notes=release.get('body',''))
        out['status']='up_to_date' if out['local_version']==out['latest_version'] else 'version_differs_review_required'
        remote=git(repo,'ls-remote',REMOTE,'HEAD')
        out['remote_head']=remote.split()[0] if remote else None
        out['head_matches']=out['remote_head']==out['local_commit']
        out['guidance']='Review release notes/current README before any update; no update is performed by this script.'
    except Exception as exc:
        out['status']='check_failed'
        out['error']=str(exc)
    return out

def main():
    p=argparse.ArgumentParser(description=__doc__)
    p.add_argument('--repo',type=Path,required=True)
    p.add_argument('--output',type=Path,required=True,help='Report in project working/QC directory')
    args=p.parse_args()
    result=check(args.repo.resolve())
    args.output.parent.mkdir(parents=True,exist_ok=True)
    args.output.write_text(json.dumps(result,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
    print(json.dumps({k:result.get(k) for k in ['status','checked_at','local_version','latest_version','head_matches','local_changes']},ensure_ascii=False))
    return 1 if result['status']=='check_failed' else 0

if __name__=='__main__': raise SystemExit(main())
