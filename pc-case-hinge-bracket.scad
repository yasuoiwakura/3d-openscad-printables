// Grundeinstellungen
wand = 4;                  // Wandstaerke
haken_abstand = 6.54;      // Abstand zwischen den Rillen
haken_breite = 3.7;        // Breite der Haken
haken_hoehe = 4;
haken_tiefe = 5;
anzahl_haken = 6;

// Monitoraufnahme
zapfen_durchmesser = 6;
zapfen_hoehe = 12;
oesen_durchmesser = 6.5;
oesen_hoehe = 4;

// Gesamthalterung
halter_hoehe = 180;
halter_breite = wand + haken_tiefe;
slot_ausschnitt_breite = 30;
slot_ausschnitt_hoehe = 20;

module hakenreihe() {
    for (i = [0 : anzahl_haken - 1]) {
        translate([0, i * haken_abstand, 0])
            cube([haken_tiefe, haken_breite, haken_hoehe]);
    }
}

module monitorhalterung() {
    difference() {
        union() {
            // Rueckplatte
            cube([halter_breite, halter_hoehe, wand]);

            // Hakenreihe oben
            translate([0, 10, wand])
                hakenreihe();

            // Zapfen unten (Monitoraufnahme)
            translate([
                halter_breite / 2 - zapfen_durchmesser / 2,
                0,
                -zapfen_hoehe
            ])
                cylinder(h = zapfen_hoehe, d = zapfen_durchmesser, $fn = 32);

            // Oese oben
            translate([
                halter_breite / 2,
                halter_hoehe,
                wand / 2
            ])
                rotate([90, 0, 0])
                    cylinder(h = wand, d = oesen_durchmesser, $fn = 32);
        }

        // Ausschnitt zur seitlichen Stabilisierung am Slotblech
        translate([
            0,
            halter_hoehe / 2 - slot_ausschnitt_hoehe / 2,
            wand / 2
        ])
            cube([halter_breite, slot_ausschnitt_hoehe, wand + 1]);
    }
}

monitorhalterung();
