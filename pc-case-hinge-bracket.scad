detail=128;
//detail=32;

z_delta_schlitze_slot = 30;

// Grundeinstellungen
wand = 4;                  // Wandstaerke
wand_monitor = 20;                  // Wandstaerke
haken_abstand = 6.54;      // Abstand zwischen den Rillen
haken_breite = 3.9;        // Breite der Haken
haken_hoehe = 5.8;
haken_grip_hoehe = 2.5;     // wie viele mm im Case nach unten einrasten wenn hinten
haken_grip_tiefe = 2;            // wie tief rein in case
haken_tiefe = 5;            // wie tief rein in case
anzahl_haken = 7;

// Monitoraufnahme
zapfen_durchmesser = 6; // 
zapfen_hoehe = 12;
oesen_durchmesser = 6.5;
oesen_hoehe = 4;

mon_dicke = 12;
mon_hoehe = 179; // 178.5 ca.


// Gesamthalterung
halter_hoehe = 180;
halter_breite = wand + haken_tiefe;

slot_breite = 45; // 46.5 Breit
slot_hoehe = 40; //<50
slot_tiefe = 10;
slot_verdecken = 10; // TODO

steg_links_breite = 015; // TODO messen wenn linke Abdeckung drauf
steg_links_hoehe  = wand_monitor+mon_hoehe+wand_monitor; // 

module steg_rechts() {
    translate([0, 0-wand, 0-z_delta_schlitze_slot-wand-slot_verdecken])
    cube([slot_breite, wand, z_delta_schlitze_slot+wand+slot_verdecken+haken_breite/2+haken_hoehe]);
}//module steg_rechts
translate([0, 0, 0])
steg_rechts();

module steg_links() {
    intersection(){
        //rotate([-90,0,0])
        translate([0-steg_links_breite/2+wand/2, 0, 0-steg_links_hoehe])
        cylinder(h=steg_links_hoehe+haken_breite/2+haken_hoehe, d=steg_links_breite+wand, $fn=detail);
        translate([0-steg_links_breite, 0-steg_links_breite, 0-steg_links_hoehe])
        cube([steg_links_breite+wand, steg_links_breite, steg_links_hoehe+haken_breite/2+haken_hoehe]);
    } //intersection
}//module steg_links
translate([0, 0, 0])
steg_links();

module Monitorhalter(){
    //cylinder(h=wand, d=zapfen_durchmesser);
    
    difference(){ //Halter oben
        translate([0-mon_dicke/2, 0-mon_dicke/2, 0])
        cube([mon_dicke,mon_dicke+steg_links_breite/2, wand_monitor]);        
        translate([0, 0, 0])
        cylinder(h=wand_monitor, d=zapfen_durchmesser, $fn=detail);
    }//difference    
    
        translate([0-mon_dicke/2, 0-mon_dicke/2, -mon_hoehe-wand_monitor])
        cube([mon_dicke,mon_dicke+steg_links_breite/2, wand_monitor]);        

        translate([0, 0, -mon_hoehe])
        cylinder(h=zapfen_hoehe, d1=zapfen_durchmesser, d2=zapfen_durchmesser*0.8, $fn=detail);
    
}//Monitorhalter

translate([0-(steg_links_breite-wand)/2, 0-steg_links_breite, 0-wand_monitor])
Monitorhalter();

module slot() {
    translate([0, 0, 0])
    cube([wand, slot_tiefe, slot_hoehe]); //slot wand links
    
    translate([0+wand, 0, slot_hoehe])
    cube([slot_breite-2*wand, slot_tiefe, wand]); //slot wand oben
    
    translate([0+wand, 0, slot_hoehe]) // Rundung oben links
    rotate([-90,0,0])
    cylinder(h=slot_tiefe, r=wand, $fn=detail/2);

    translate([0+slot_breite-wand, 0, slot_hoehe]) // Rundung oben rechts
    rotate([-90,0,0])
    cylinder(h=slot_tiefe, r=wand, $fn=detail/2);

    
    translate([slot_breite-wand, 0, 0])
    cube([wand, slot_tiefe, slot_hoehe]); //slot wand rechts

    
}
translate([0,0, -z_delta_schlitze_slot -slot_hoehe -wand])
slot();

module hakenreihe() {
    for (i = [0 : anzahl_haken - 1]) {
        //aussenseite
        translate([i * haken_abstand, 0, 0+haken_breite/2])
            cube([haken_breite, haken_tiefe, haken_hoehe]);
        translate([i * haken_abstand + (haken_breite/2), 0, 0+haken_breite/2])
        rotate([-90,0,0])
            cylinder(h=haken_tiefe, d=haken_breite, $fn=detail/2);
        //innenseite Rastnasen
        translate([i * haken_abstand, haken_tiefe, -haken_grip_hoehe+haken_breite/2])
            cube([haken_breite, haken_tiefe, haken_hoehe+haken_grip_hoehe]);
        translate([i * haken_abstand + (haken_breite/2), haken_tiefe, -haken_grip_hoehe+haken_breite/2])
        rotate([-90,0,0])
            cylinder(h=haken_tiefe, d=haken_breite, $fn=detail/2);
    }
}
translate([0,0, 0])
hakenreihe();

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

//monitorhalterung();
