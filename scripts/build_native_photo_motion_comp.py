"""Build an editable native Fusion .comp from a static full-frame PNG.
No Resolve connection, timeline mutation or video rendering. Values are examples;
review crop/cover and measure importer/frame domain on the actual Resolve build.
Usage from project tooling: write_motion_comp({"path": absolute_png,
"duration_frames": N, "mode": "pan_right"}, destination_comp, fps=timeline_fps).
"""
import json
from pathlib import Path
def write_motion_comp(x,destination,width=3840,height=2160,fps=24):
 assert isinstance(x["duration_frames"],int) and x["duration_frames"]>=2
 assert x["mode"] in ["pan_left","pan_right","zoom_in","zoom_out"]
 assert Path(x["path"]).is_file() and Path(x["path"]).suffix.lower()==".png"
 assert width>0 and height>0 and fps>0
 if x['mode'].startswith('pan'):
  assert x.get('pan_scale',1.12)>=1+2*abs(x.get('pan_half_travel',.042)), 'Overscan insufficient for pan'
 else:
  assert x.get('min_scale',1.03)>=1 and x.get('max_scale',1.12)>x.get('min_scale',1.03)
 n=x['duration_frames'];end=n-1;mode=x['mode'];path=json.dumps(x['path'],ensure_ascii=False)
 nodes=[f'''Photo = Loader {{ Clips = {{ Clip {{ ID = "Clip1", Filename = {path}, FormatID = "PNGFormat", Length = 1, LengthSetManually = true, GlobalStart = 0, GlobalEnd = {end}, TrimIn = 0, TrimOut = 0, ExtendLast = {end} }} }}, Inputs = {{ GlobalOut = Input {{ Value = {end} }}, ClipTimeEnd = Input {{ Value = 0 }}, Loop = Input {{ Value = 1 }} }} }}''']
 center='Value = {0.5,0.5}';size=f'Value = {x.get("pan_scale",1.12)}'
 if mode in ['zoom_in','zoom_out']:
  a,b=(x.get("min_scale",1.03),x.get("max_scale",1.12)) if mode=='zoom_in' else (x.get("max_scale",1.12),x.get("min_scale",1.03))
  size='SourceOp = "ZoomKeys", Source = "Value"'
  nodes.append(f'ZoomKeys = BezierSpline {{ SplineColor = {{ Red = 255, Green = 128, Blue = 64 }}, KeyFrames = {{ [0] = {{ {a}, Flags = {{ Linear = true }} }}, [{end}] = {{ {b}, Flags = {{ Linear = true }} }} }} }}')
 else:
  a,b=(.5+x.get("pan_half_travel",.042),.5-x.get("pan_half_travel",.042)) if mode=='pan_right' else (.5-x.get("pan_half_travel",.042),.5+x.get("pan_half_travel",.042))
  center='SourceOp = "PanPath", Source = "Value"'
  nodes.append('PanPath = XYPath { Inputs = { X = Input { SourceOp = "PanKeys", Source = "Value" }, Y = Input { Value = 0.5 } } }')
  nodes.append(f'PanKeys = BezierSpline {{ SplineColor = {{ Red = 64, Green = 180, Blue = 255 }}, KeyFrames = {{ [0] = {{ {a}, Flags = {{ Linear = true }} }}, [{end}] = {{ {b}, Flags = {{ Linear = true }} }} }} }}')
 nodes.append(f'PhotoMotion = Transform {{ Inputs = {{ Input = Input {{ SourceOp = "Photo", Source = "Output" }}, Center = Input {{ {center} }}, Size = Input {{ {size} }}, Pivot = Input {{ Value = {{0.5,0.5}} }}, Aspect = Input {{ Value = 1 }}, Angle = Input {{ Value = 0 }}, MotionBlur = Input {{ Value = 0 }} }} }}')
 nodes.append('MediaOut1 = Saver { Inputs = { Index = Input { Value = "0" }, Input = Input { SourceOp = "PhotoMotion", Source = "Output" } } }')
 destination=Path(destination);destination.parent.mkdir(parents=True,exist_ok=True)
 prefs=f' }}, Prefs = {{ Comp = {{ FrameFormat = {{ Width = {width}, Height = {height}, Rate = {fps} }} }} }} }}'
 destination.write_text(f'Composition {{ RenderRange = {{0,{end}}}, GlobalRange = {{0,{end}}}, Tools = {{ '+',\n'.join(nodes)+prefs,encoding='utf8')
 return destination
