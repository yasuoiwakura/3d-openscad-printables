union() {
    // Bodenplatte mit hohler Basis (unten)
    difference() {
        translate([0, 0, 0])  // Start ganz unten
            cylinder(d=30, h=4, $fn=128);  // Bodenplatte

        translate([0, 0, -0.1])  // Innere Aushöhlung leicht tiefer
            cylinder(d=11.5, h=4.2, $fn=128);
    }

    // Hohler Zylinder darüber (Stütze)
    difference() {
        translate([0, 0, 4])  // direkt über dem Boden
            cylinder(d=15.5, h=136, $fn=128);  // äußere Wand

        translate([0, 0, 3.9])  // innerer Hohlraum
            cylinder(d=11.5, h=141.1, $fn=128);
    }

    // Deckplatte mit Schraubenaussparung und GPU-Lüfterausschnitt
    difference() {
        translate([0, 0, 140])  // ganz oben
            cylinder(d=30, h=4, $fn=128);  // obere Abdeckung

        translate([0, 0, 142])  // Schraubenaussparung
            cylinder(d=8, h=2.1, $fn=128);

        translate([-57, -25, 142])  // Lüfterausschnitt oben
            cylinder(d=114, h=2.1, $fn=128);
    }
}
