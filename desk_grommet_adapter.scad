union() {
difference() {

    // MATERIAL START //
    union() { 
        // Hauptzylinder
        translate([0, 0, 0+10])
            cylinder(d=59, h=26-10, $fn=128);

        // Oberer Überstand zur Auflage
        translate([0, 0, (26)])
            cylinder(d1=80, d2=64, h=10, $fn=128); // LOCH TISCH d<80

        // Außenliegende Clips zum Einrasten im Tischloch
        for (angle = [0, 120, 240, 0+40, 120+40, 240+40, 0+80, 120+80, 240+80]) {
            rotate([0, 0, angle+25]) {
                intersection(){
                     // nachfolgende Würfel begrenzt auf Hauptzyliner-Radius
                    union(){
                        translate([0, 0, -4])
                        cylinder(d=59, h=4+26, $fn=128);

                        translate([0, 0, -8])
                        cylinder(d1=57, ,d2=59, h=4, $fn=128);
                    }

                    // Federarm – schmaler Steg (innen begrenzt)
                    translate([59/2 - 1-1, -4, -8])  // Außen: Zylinder (r=29.5)
                    cube([2, 8, 8+10], center=false);  // (Breite x Tiefe x Höhe)
                }
                // Rastnase – überstehender Stopper
                translate([59/2-0.5, 1, 0-2])  // vorne oben auf dem Steg
                rotate([90, 0, 0])
                cylinder(d=4, h=2, $fn=32);  // runde Nase
            }
        }

    }// MATERIAL ENDE // 



    // ABZÜGE START //
    // Innenausschnitt für USB-Modul
    translate([0, 0, -0.1])
        cylinder(d=45, h=111, $fn=128); // MODUL d=45

    // Nase unten rund machen
    translate([0, 0, -4])
        cylinder(d=57, h=4+10, $fn=128); // MODUL d=45

    // Löcher (4x im Kreis) zum festschrauben an USB
    for (angle = [0, 90, 180, 270]) {
        rotate([0, 0, angle+45])
            translate([0, 45/2+5, 26+2])
                cylinder(d=1.5, h=11, $fn=32);
    }

    // Auslass für USB-Außenstege (3x im Kreis)
    for (angle = [0, 120, 240]) {
        rotate([0, 0, angle])
            translate([0, 22.5, -0.1])
                cylinder(d1=3.5, d2=4.2, h=0.1+26+10+0.1, $fn=32);
    }

    // eventuelle Kabeldurchführungen:
    for (angle = [0, 120]) {
        rotate([0, 0, angle+35])
        translate([0, 64/2-2, -0.1])
        //Option 1: 2x Loch nur unter Überhang
        cylinder(d=10, h=26+0.1, $fn=32);
    }
    // reale Kabeldurchführung:
    for (angle = [240]) {
        rotate([0, 0, angle+35])
        translate([0, 64/2-8/2, -0.1])
        // Option 2 - 1x Langloch durch die Außenkante
        translate([0, 0, -0.1])
            rotate([0, 0, 0])  // Ausrichtung anpassen
                linear_extrude(height=0.1+26+10-1)  // etwas höher
                offset(r=4, $fn=64)  // Rundung an den Enden
                // Schlitz (Breite exkl. Rundung x Länge)                        
                square([2, 20], center=false);  
    }

    // 3 Bohrkanäle f+r Tisch
    for (angle = [0, 120, 240]) {
        rotate([0, 0, angle+50])
            translate([33, 0, 12])
                rotate([0, -45-15, 0])
                    cylinder(d1=1, d2=12, h=20, $fn=64);
    }// ABZÜGE ENDE //

}
//Test-Objekte ohne Löcher



}