//use <../_wall_with_holes.scad>;


// Modul für perforierte Wand mit Wabenmuster (Hexagon)
// size: Vektor [width, thickness, height] entsprechend cube(size)
// hex_size: Abstand von Mitte zu Mitte einer Wabe (definiert auch die Lochgröße)
// hole_d: Durchmesser der Bohrlöcher in mm
// margin: Randabstand ohne Löcher
module _wall_with_holes(size, hex_size, hole_d, margin=0, fn=128) {
    width = size[0];
    thickness = size[1];
    height = size[2];

    difference() {
        // Basisquader
        cube(size);

        // Hexagon-Muster aus Löchern
        for (row = [0 : floor(height / (hex_size * 0.866))]) {  // 0.866 = sin(60°)
            for (col = [0 : floor(width / hex_size)]) {
                // Versatz jeder zweiten Reihe (hexagonal)
                x = col * hex_size + ((row % 2) * hex_size / 2);
                z = row * hex_size * 0.866;

                // Prüfe Randabstand (margin)
                if (x >= margin && x <= (width - margin) && z >= margin && z <= (height - margin)) {
                    translate([x, thickness / 2, z])
                        rotate([90, 0, 0])
                        cylinder(h = thickness + 1, d = hole_d, center = true, $fn = fn/4);
                }
            }
        }
    }
}

// Beispielaufruf: Wand 120x5x80, Wabengröße 6 mm, Lochdurchmesser 3 mm, Rand 5 mm
_wall_with_holes([120, 5, 80], 6, 3, 5);

