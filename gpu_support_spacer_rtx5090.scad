difference(){
    union() {
        // Bodenplatte mit hohler Basis (unten)
        translate([0, 0, 0])
            cylinder(d=30, h=4, $fn=128);

        // Hauptzylinder (20mm Außendurchmesser, optional hohl)
        translate([0, 0, 4])
            cylinder(d=20, h=134, $fn=128);  // 4–138mm

        // Konische Verjüngung zur Deckplatte (von Ø20 auf Ø30 in 2mm)
        translate([0, 0, 130])
            cylinder(h=10, d1=20, d2=30, $fn=128);

        
        // Deckplatte mit Aussparungen
        difference() {
            translate([0, 0, 140])
                cylinder(d=30, h=4, $fn=128);  // Deckplatte

            translate([0, 0, 142])
                cylinder(d=8, h=2.1, $fn=128);  // Schraube

            translate([-57, -25, 142])
                cylinder(d=114, h=2.1, $fn=128);  // GPU-Lüfterausschnitt
        }

//        translate([ -7, -7, 144 ])  // zentriert bei (0, 0), Höhe 142 mm
//            color("red")
//                cube([3, 3, 3]);


//        translate([ -5.2, -5.2, 144 ])  // 
//            color("red")
//                cylinder(d=3, h=2, $fn=128);  // testzylinder rot

    }
    
    translate([-57, -25, 130])
    cylinder(h=12.01, d1=104, d2=107, $fn=512); // GPU-Lüfterausschnitt
    
    translate([0, 0, -0.1])
    cylinder(d=11.5, h=130.1, $fn=128);  // innen hohl 

// Konische Verjüngung innen
    translate([0, 0, 130])
    cylinder(h=10, d1=11.5, d2=2, $fn=128);


    //translate([0, 0, 139.9])
    //cylinder(d=2, h=4.2, $fn=6);  // 6eck zum Durchgucken

    translate([0, 0, 139.9])
    cylinder(d=2, h=4.2, $fn=65);  // Loch zum Durchgucken

}