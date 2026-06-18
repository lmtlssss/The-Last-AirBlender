import sys
from pathlib import Path
import bpy
ADDON_DIR = Path(__file__).resolve().parents[2] / 'addon'
sys.path.insert(0, str(ADDON_DIR))
if 'last_airblender' in sys.modules:
    try:
        sys.modules['last_airblender'].unregister()
    except Exception:
        pass
    del sys.modules['last_airblender']
import last_airblender as d
if hasattr(bpy.types.Scene, 'drone_flight_recorder_settings'):
    try:
        d.unregister()
    except Exception:
        pass
d.register()
bpy.ops.object.select_all(action='SELECT'); bpy.ops.object.delete()
scene=bpy.context.scene
# Fake an Xbox controller visible to Blender and a backend that can be opened.
d.LinuxJoystickBackend.list_devices = staticmethod(lambda: [('/dev/input/js0', 'Microsoft X-Box Test Pad', 8, 12)])
class FB:
    connected=True; path='/dev/input/js-test'; name='Microsoft X-Box Test Pad'; error=''; buttons={}; axes={}
    def open(self, *_): self.connected=True; return True
    def close(self): self.connected=False
    def poll(self): pass
    def axis(self, idx, default=0.0): return -1.0 if idx in (2,5) else 0.0
    def button(self, idx): return False
fb=FB(); d.RUNTIME.backend=fb; d.RUNTIME.timer_running=False; d.RUNTIME.stop_requested=False
ok=d.auto_arm_if_controller_present(bpy.context)
print('AUTOARM_OK', ok, scene.camera.name if scene.camera else None, d.RUNTIME.timer_running, scene.drone_flight_recorder_settings.status)
assert ok is True
assert scene.camera and scene.camera.name.startswith('AirBlender_Cam_')
assert d.RUNTIME.timer_running is True
assert d.get_rig_objects()[0] is not None
assert d.get_roll_object() is not None
print('AUTOSENSE_AUTOARM_SMOKE_OK')
