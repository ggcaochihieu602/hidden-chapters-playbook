"""MP2-owned adaptation of FrameForge OmniVoice inference; model weights are read-only."""
import hashlib
import json
import sys
from pathlib import Path

def main():
    import soundfile as sf
    import torch
    from omnivoice import OmniVoice
    request=json.loads(Path(sys.argv[1]).read_text(encoding='utf-8'))
    cuda=torch.cuda.is_available()
    model=OmniVoice.from_pretrained(request['model'],device_map='cuda:0' if cuda else 'cpu',dtype=torch.float16 if cuda else torch.float32,load_asr=False)
    voice=request['voice']; reference=request.get('reference'); instruct=request.get('instruct')
    if reference:
        prompt=model.create_voice_clone_prompt(reference,request['reference_text'])
    else:
        folder=Path(request['preset_root']); folder.mkdir(parents=True,exist_ok=True)
        design=instruct or ('male, middle-aged, low pitch, american accent' if voice.startswith(('am_','bm_')) else 'female, middle-aged, low pitch, american accent')
        preset_key=hashlib.sha256((voice+'|'+design).encode()).hexdigest()[:12]
        preset=folder/(voice+'-'+preset_key+'.wav'); sample='Every story begins with a question. Listen carefully, and the answer will reveal itself.'
        if not preset.exists():
            torch.manual_seed(int(hashlib.sha256(voice.encode()).hexdigest()[:8],16))
            audio=model.generate(text=sample,language='en',instruct=design,num_step=32)[0]
            sf.write(str(preset),audio,model.sampling_rate)
        prompt=model.create_voice_clone_prompt(str(preset),sample)
    for item in request['items']:
        torch.manual_seed(42)
        kwargs={'text':item['text'],'language':request['language'],'num_step':32,'voice_clone_prompt':prompt,'speed':request.get('speed',1)}
        if instruct: kwargs['instruct']=instruct
        with torch.inference_mode(): audio=model.generate(**kwargs)[0]
        output=Path(item['output']); temporary=output.with_suffix('.partial.wav')
        sf.write(temporary,audio,model.sampling_rate); temporary.replace(output)

if __name__=='__main__': main()
