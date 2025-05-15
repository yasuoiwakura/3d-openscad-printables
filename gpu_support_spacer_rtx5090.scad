union() {
    // Bodenplatte mit Aussparung für Schraubenkopf
    difference() {
        cylinder(d=30, h=4, $fn=128);  // Bodenplatte

        // Aussparung für Schraubenkopf (8mm Durchmesser, 2mm tief)
        translate([0, 0, 0])  // liegt auf Bodenplatte unten
            cylinder(d=8, h=2, $fn=128);

        translate([57, 25, -0.1])  // Lüfter
            cylinder(d=114, h=2.1, $fn=128);
    }

    // Hohler Zylinder darauf
    difference() {
        translate([0, 0, 4])  // Zylinder steht auf Bodenplatte
            cylinder(d=15.5, h=20, $fn=128);

        translate([0, 0, 4])  // Innenhohlraum
            cylinder(d=11.5, h=21, $fn=128);
    }
}
