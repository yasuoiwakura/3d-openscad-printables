// Modul: aussparung
// Erzeugt einen gebogenen Balken (Radius 1m) mit radialer Breite delta_r und Hoehe schiene_tiefe, zentriert.

// Parameter
schiene_laenge = 50;          // Radiale Breite der Aussparung (mm)
schiene_hoehe = 10;   // Hoehe des Balkens (mm)
schiene_tiefe = 13;
monitor_radius = 1000;  // Radius der Biegung (mm)

wand=2;
fn = 512;               // $fn Aufloesung fuer Boegen
//fn=fn*10;

module bogen(tiefe, wand_vorne=0, wand_oben=0, schraege_hinten=0, delta_laenge=0) {
    angle = (schiene_laenge+delta_laenge) / monitor_radius * 180 / PI;  // Biegung

    translate([0,-monitor_radius+wand_vorne,-schiene_hoehe-wand_oben])
    rotate([0,0,90-angle/1])
    
    rotate_extrude(angle = angle, $fn=fn)
        translate([monitor_radius, 0])
                union(){
                    square([tiefe, schiene_hoehe], center = false);
                    polygon(points=[
                        [tiefe,  schiene_hoehe],
                        [tiefe, 0],
                        [tiefe+schraege_hinten, 0]
                    ]
                    //,center = false
                    );
                };
}
// Aufruf des Moduls
    
difference(){ // Schiene
    //translate([0,0,0])
    bogen(13+2+5);
    //cube();
    
    bogen(  schiene_tiefe,
            wand_vorne=wand, wand_oben=wand,
            delta_laenge=1,
            schraege_hinten=5
    );//*/
}
