// Modul: aussparung
// Erzeugt einen gebogenen Balken (Radius 1m) mit radialer Breite delta_r und Hoehe schiene_tiefe, zentriert.

// Parameter
schiene_laenge = 50;          // Radiale Breite der Aussparung (mm)
schiene_hoehe = 10;   // Hoehe des Balkens (mm)
schiene_tiefe = 13;
monitor_radius = 1000;  // Radius der Biegung (mm)
fn = 512;               // $fn Aufloesung fuer Boegen
//fn=fn*10;

module aussparung() {
    angle = schiene_laenge / monitor_radius * 180 / PI;  // Biegung

    translate([0,-monitor_radius-schiene_tiefe/2,-schiene_hoehe])
    rotate([0,0,90-angle/2])
    
    rotate_extrude(angle = angle, $fn=fn)
        translate([monitor_radius, 0])
            square([schiene_tiefe, schiene_hoehe], center = false);
}
// Aufruf des Moduls
aussparung();
