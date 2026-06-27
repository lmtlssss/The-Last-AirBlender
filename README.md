# the last airblender

blender camera flight with an xbox controller.

record camera moves as animation takes.
scrub a take, overwrite from the playhead, and save camera screenshots beside the blend file.

```text
THE LAST AIRBLENDER
──────────────────────────────────────────────────────────────

xbox controller  ──►  blender viewport  ──►  camera rig
                                            │
                                            ├─ animation takes
                                            └─ screenshots
```

## install

### linux / macos

```bash
curl -fsSL https://raw.githubusercontent.com/lmtlssss/The-Last-AirBlender/main/install.sh | sh
```

inspect first:

```bash
curl -fsSLO https://raw.githubusercontent.com/lmtlssss/The-Last-AirBlender/main/install.sh
less install.sh
sh install.sh
```

pin a release:

```bash
LAST_AIRBLENDER_VERSION=v1.0.4 sh install.sh
```

### windows powershell

```powershell
irm https://raw.githubusercontent.com/lmtlssss/The-Last-AirBlender/main/install.ps1 | iex
```

inspect first:

```powershell
irm https://raw.githubusercontent.com/lmtlssss/The-Last-AirBlender/main/install.ps1 -OutFile install.ps1
notepad install.ps1
powershell -ExecutionPolicy Bypass -File .\install.ps1
```

### release files

```text
file                         system
──────────────────────────────────────────────────────────────
.deb                         ubuntu / debian
.rpm                         fedora / rhel
.msi                         windows
.pkg                         macos
last-airblender-addon.zip    manual blender add-on
```

## start

open blender normally.
plug in an xbox controller.

when blender sees the controller, airblender arms the camera rig and shows a small controller icon in the 3d viewport.

```text
viewport icon
──────────────────────────────────────────────────────────────
left click      activate / re-arm
right click     controls menu
```

cli checks:

```bash
last-airblender doctor
last-airblender launch your-scene.blend
```

## controls

```text
control                  action
──────────────────────────────────────────────────────────────
start / menu             cycle cameras
start double tap         create AirBlender_Cam_### at current view
start triple tap         delete current camera

left stick x             strafe left / right
left stick y             move forward / back
right stick              look
rb / lb                  rise / fall
rb / lb double tap       auto rise / fall
rb / lb while auto       reverse auto direction
rt / lt                  roll
l3 + rt / lt             focal length

x                        speed: low / medium / high / xhigh
y                        invert look, roll, and rise/fall
a                        show / hide controls overlay
b                        toggle third-person side pane
r3                       portrait / landscape camera frame

d-pad up                 screenshot
d-pad down               record / stop / overwrite
d-pad left / right       scrub active take
select / back            cycle take slots 1-10
select double tap        jump to a new / empty take slot
```

## take workflow

```text
01  open blender
02  plug in controller
03  airblender arms
04  start double tap       create camera
05  fly
06  d-pad down             record
07  fly the take
08  d-pad down             stop
09  d-pad left / right     scrub
10  d-pad down             overwrite from playhead
```

## screenshots

press d-pad up.

```text
<your-blend-folder>/last_airblender_screenshots/
```

## scene names

new helpers:

```text
AirBlender_Camera_Fleet
AirBlender_Airframe
AirBlender_Gimbal
AirBlender_Horizon
AirBlender_Cam_###
LAB_* actions and markers
```

older scene names are still supported:

```text
Drone_Rig
Drone_Gimbal
Drone_Roll
DFR_* actions and markers
```

## doctor

```bash
last-airblender doctor
```

```text
blender not found        set BLENDER=/path/to/blender
controller not found     plug in the xbox controller and rerun doctor
linux permissions        make sure game controllers are readable
unsigned packages        v1.0.4 packages may be unsigned
```

## build

```bash
cargo build --release
scripts/package-deb.sh
```

blender smoke test:

```bash
/snap/bin/blender --background --python tests/blender/smoke_dpad_scrub_after_stop.py
```
