detail=128;
detail=32;

nose_thick = 1;
nose_thin = 5;
nose_grip = 2;
nose_wid = 9;

dia_table = 59;
dia_usb = 45;

nose_angle_offset = 15;

union() {
difference() {

    // MATERIAL START //
    union() { 
        // Oberer Überstand zur Auflage
        translate([0, 0, (26)])
            cylinder(d1=80, d2=64, h=10, $fn=4*detail); // LOCH TISCH d<80

        // Hauptzylinder
        translate([0, 0, 0+10])
            cylinder(d=dia_table, h=26-10, $fn=detail);

    // Vergüngung für Nasen //
    difference(){
        intersection(){
            union(){ //intersection part 1
                for (angle = [0, 120, 240, 0+40, 120+40, 240+40, 0+80, 120+80, 240+80]) {
                    translate([0, 0, 0-10])
                    rotate([0, 0, angle+nose_angle_offset]) {
                        cube([40, nose_wid ,25], center=false);   
                    }
                }; //for
            }; //union
        union(){ //intersection part 2: OUTSIDE LIMITERS
            translate([0, 0, 0])
                cylinder(d=dia_table, h=10, $fn=detail);
            translate([0, 0, 0-10])
                cylinder(d2=dia_table+nose_grip*2, d1=dia_table-nose_grip*2, h=10, $fn=detail);
        }; // union
        }; //intersection
        // difference part 2: INSIDE LIMITERS
        union(){
            translate([0, 0, 0-10])
                cylinder(d2=dia_usb, d1=dia_table-nose_grip*2-nose_thick*2, h=20, $fn=detail);
            
            }
    }; // diff
    // ENDE Verjüngung für Nasen //

    }// MATERIAL ENDE // 



    // ABZÜGE START //
    // Innenausschnitt für USB-Modul
    translate([0, 0, -0.1])
        cylinder(d=dia_usb, h=111, $fn=detail); // MODUL d=45

    // Nase unten rund machen
//    translate([0, 0, -4])
//        cylinder(d=57, h=4+10, $fn=detail); // MODUL d=45
    translate([0, 0, 0-5])
        sphere(d=dia_table-nose_grip*2-nose_thick*2, $fn=detail);



    // Löcher (4x im Kreis) zum festschrauben an USB
    for (angle = [0, 90, 180, 270]) {
        rotate([0, 0, angle+45])
            translate([0, 45/2+5, 26+2])
                cylinder(d=1.5, h=11, $fn=detail/4);
    }

    // Auslass für USB-Außenstege (3x im Kreis)
    for (angle = [0, 120, 240]) {
        rotate([0, 0, angle])
            translate([0, 22.5, -0.1])
                cylinder(d1=3.5, d2=4.2, h=0.1+26+10+0.1, $fn=detail/4);
    }

    // eventuelle Kabeldurchführungen:
    for (angle = [0, 120]) {
        rotate([0, 0, angle+35])
        translate([0, 64/2-2, -0.1])
        //Option 1: 2x Loch nur unter Überhang
        cylinder(d=10, h=26+0.1, $fn=detail/4);
    }
    // reale Kabeldurchführung:
    for (angle = [240]) {
        rotate([0, 0, angle+35])
        translate([0, 64/2-8/2, -10])
        // Option 2 - 1x Langloch durch die Außenkante
        translate([0, 0, -0.1])
            rotate([0, 0, 0])  // Ausrichtung anpassen
                linear_extrude(height=10+26+10-1)  // etwas höher
                offset(r=4, $fn=detail/2)  // Rundung an den Enden
                // Schlitz (Breite exkl. Rundung x Länge)                        
                square([2, 20], center=false);  
    }

    // 3 Bohrkanäle f+r Tisch
    for (angle = [0, 120, 240]) {
        rotate([0, 0, angle+50])
            translate([33, 0, 12])
                rotate([0, -45-15, 0])
                    cylinder(d1=1, d2=12, h=20, $fn=detail/2);
    }// ABZÜGE ENDE //

}
//Test-Objekte ohne Loecher


}