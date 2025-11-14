# 3d-openscad-printables
A small printables-as-code library of assorted parametric OpenSCAD models
![several 3d printables on computer versus photo](./assets/img/_3d-openscad-printables_collage.jpg)

## Problem
1. STL-Models on makerworld etc. are fix
3. Modifications using Slicer Apps are bothersome and often inaccurate
3. Buying Fusion360 not quite cheap (plus closed source)

## solution approach
Design-as-Code approach OpenSCAD[https://openscad.org/] enabling parameters, logic and use Git versioning. It also can export STL-Files for your Slicer.
Creating them can by time-consuming (even with ai), so I'm publishing my objects here for personal use.

## license
### CC BY-NC 4.0
I want to protect from Temu and mass-resellers, so I set the default license:

CC BY-NC 4.0 Matthias Block https://creativecommons.org/licenses/by-nc/4.0/legalcode
Please  drop a message if you need commercial licenses or the license is hindering you from participating - just let me know!

# Models

---

## desk grommet adapter
Desk USB Hole Reducer Adapter

This 3D-printed adapter reduces an oversized round desk hole (approximately 59 mm diameter) to fit a standard USB grommet (45 mm diameter). It features snap-fit locking tabs for secure installation and screw holes for mounting the USB module. The design includes cable cutouts and a flange for stable seating on the desk surface.
![4 pictures showing Desk USB hole reducer adapter with lots of screw bosses and feed-through](./assets/img/desk_grommet_adapter_collage.jpg)

### **Problem**

* The new desk has a 59 mm hole.
* The USB socket is 45 mm wide.
* The socket isn’t fully round due to the **screw bosses**.
* An extra cable for the Surface Dock needs to pass through.

### **Solution**

* A custom **59 mm → 45 mm adapter**.
* **Clearance for the screw bosses** of the USB module.
* A **cable feed-through** for the additional dock cable.
* **Snap tabs** to hold the module in place (though PLA tabs may be fragile).
* **Optional screw holes** to mount the adapter to the desk if the tabs fail.

### **Rating**

* + everysize is round, easy to design
* + works flawless
* + i used a tiny screw to fixate the adapter
* - snap tabs break easily (PLA material), so not many installation-tries, feed-through not easy to replace

### Parameters
* dia_table = 59; // outer diameter
* dia_usb = 45; // inner diameter 
* and some adjesments for the snaps/noses
* detail=128; // use 128 for print or 32 for faster preview
* nose_angle_offset = 15; // snaps adjustments may interfere with cutouts
* if you need >1 extra Feed-through, code needs to be adjusted (no parameter yet)

---

## Footswitch Carriage
lock your USB HID Pedal along your Desktop Foot
![Carriage](./assets/img/footswitch_carriage_render.png)

### Problem
You unwantingly kick way your usb footswitch pedal
### Solution
* Horizontal table stand as rail to lock footswitch
* light cable management
### Rating
* + works - pedal always in place!
* + no glue or weird provisioning
* - not super solid if you kick it often
* - pretty ugly since only cylinder() and cube() was used
### Todo
* remake using advanced OpenSCAD libraries (not scheduled tho)

### Main Parameters:

## gpu_support_spacer_rtx5090
Minimalist GPU support cylinder with screw hole and fan outlet on top.
![3d-printed GPU Support cylinder](./assets/img/gpu_support_spacer_collage_1.jpg)
### Problem
* RTX 5090 is pretty heavy and the TUF Stand is too short
* Other GPU spacers would need Tape or Glue to fixate
### Solution
* Cylinder with cutout for fan and screw at the edge for stable stand
### Rating / TODO
* works
* upper part
* suggest vibration-reducing bumbers
* the stand if not super stable - you might want to make the lowest part wider
* the screw is a bit bigger - might need adjustment to fit even better.
* - The Design is functional but the Design aspect not too creative,
### Suggestion
In your slicer, combine the solid upper part with something more creative like an animefigure etc.


## anime figure stand (rail) for curved Samsung 9G Monitor
PLACEHOLDER

## mount portable monitor to pc back
PLACEHOLDER

## Optiplex wal mount