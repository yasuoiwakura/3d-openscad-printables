/*
use <../_bohr_senk.scad>;
*/

bohr_senk(d=4.5, d2=9, h=15, h_senk=3.5, axis="y", dir=1);

module bohr_senk(x=0, y=0, z=0, h=15, d=4.2+0.3, d2=9, h_senk=3.5, axis="y", dir=1, fn=100, ) {
    // Positionierung mit translate
    translate([x, y, z]) {
        // Rotation je nach Achse
        rotate(axis == "y" ? [270 * dir, 0, 0] : 
               axis == "x" ? [0, 90 * dir, 0] : 
               [90 - 90*dir, 0, 0]) {
            // Senkung (größerer Durchmesser)
            cylinder(h = h_senk, d1=d2, d2=d, $fn=fn);
            // Bohrloch (kleinerer Durchmesser)
            translate([0, 0, h_senk]) {
                cylinder(h = h, d = d, $fn=fn);
            }
        }
    }
}