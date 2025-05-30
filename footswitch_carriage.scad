// Grundeinstellungen
wall = 2;                 // Wanddicke
base_thickness = 3;        // Stärke der Bodenplatte

// Tischfuß
tisch_breite = 70+5;         // Tischfuß-Breite
tisch_len = 120;           // geschätzt
tisch_high = 30;           // Wandhöhe für Führung

// Pedal
pedal_x_breite = 64+2;
pedal_y_len = 101+2;
pedal_high_front = 5;      // Wandhöhe vorne
pedal_high_back = 10;      // Wandhöhe hinten

pedal_roof_len = 4;          // 5.5mm Luft
pedal_roof_sidedistance = 10;

// USB
usb_breite = wall;
usb__high = 8;

d_cable_left = 5;

// Positionierung
abstand_zwischen = 20;
gesamt_x_breite = wall + tisch_breite + wall + abstand_zwischen + wall + pedal_x_breite + wall;
gesamt_y_laenge = max(tisch_len, pedal_y_len) + wall * 2;

module halterung() {
    translate([0, 0, 0])
    difference() {
        union() {
            // Grundplatte
            cube([gesamt_x_breite, gesamt_y_laenge, base_thickness]);

            // Tischfuß linke Wand
            translate([0, 0, base_thickness])
                cube([wall, gesamt_y_laenge, tisch_high]);

            // Tischfuß rechte Wand
            translate([wall + tisch_breite, 0, base_thickness])
                cube([wall, gesamt_y_laenge, tisch_high]);

            ////// Koordinatenursprung für Pedalbereich ///////
            x_pedal = wall + tisch_breite + wall + abstand_zwischen + wall;

            // Pedal Vorne (unten bei Y)
            translate([x_pedal, 0, base_thickness])
                cube([pedal_x_breite, wall, pedal_high_front]);

            // Pedal Hinten (oben bei Y)
            translate([x_pedal, gesamt_y_laenge - wall, base_thickness])
                cube([pedal_x_breite, wall, pedal_high_back]);

            // Pedal roof/Halter hinten
            translate([x_pedal+pedal_roof_sidedistance, gesamt_y_laenge - wall - pedal_roof_len, base_thickness+pedal_high_back])
                cube([pedal_x_breite-pedal_roof_sidedistance*2 + wall, pedal_roof_len+wall, wall]);


            // Pedal links -x
            translate([x_pedal - wall, 0, base_thickness])
                cube([wall, gesamt_y_laenge, pedal_high_back]);

            // Pedal rechts +x
            translate([x_pedal + pedal_x_breite, 0, base_thickness])
                cube([wall, gesamt_y_laenge, pedal_high_back]);
                
            // Kabeldurchfuehrung rechts
            translate([wall + tisch_breite + wall, gesamt_y_laenge, 14])
                rotate([0,90,0])
                intersection(){
                    difference(){
                        cylinder(h=abstand_zwischen+wall+pedal_x_breite/2, r=14);
                        cylinder(h=abstand_zwischen+wall+pedal_x_breite/2, r=11);
                    }
                    cube([999,999,999]);
                    }
            // bumber hinten
        translate([0, gesamt_y_laenge, base_thickness])
                rotate([0,90,0])
                cylinder(h=wall+tisch_breite+wall, r=base_thickness, $fn=32);
//            }


            // Schutz für Kabeldurchführung
        translate([0, pedal_y_len, base_thickness*0])
                rotate([0,90,0])
                cylinder(h=wall+tisch_breite+wall, r=10, $fn=32);
//            }
                    
            
        }

        // USB-Ausschnitt in der hinteren Pedal-Wand
        translate([
            wall + tisch_breite + wall + abstand_zwischen + wall + pedal_x_breite/2 - wall,  // x-Position an hinterer Pedalwand
            gesamt_y_laenge - wall - pedal_roof_len,
            base_thickness + 5
        ])
                cube([wall, usb_breite + pedal_roof_len, usb__high]);

        
        //Auslass Kabel links
        translate([0, pedal_y_len-d_cable_left/2, base_thickness+d_cable_left/2-1])
            cube([wall+tisch_breite+wall+abstand_zwischen, d_cable_left, 123]);

        translate([0, pedal_y_len, base_thickness+d_cable_left/2-1])
                rotate([0,90,0])
                cylinder(h=wall+tisch_breite+wall+abstand_zwischen, d=d_cable_left, $fn=32);
//            }
                

        // alles unter Hauptplatte weg
        translate([0,0,-10])
            cube([999, 999, 10]);
            
    }
}

halterung();
