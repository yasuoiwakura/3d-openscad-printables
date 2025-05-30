detail=128;
//detail=32;

z_delta_schlitze_slot = 30;

// Grundeinstellungen
wand = 4;                  // Wandstaerke
wand_monitor = 20;                  // Wandstaerke
haken_abstand = 6.54;      // Abstand zwischen den Rillen
haken_breite = 3.9;        // Breite der Schlitze fuer Berechnung der Positionen
haken_breite_druck = 3;        // Druck der Haken etwas schmaler, sodass es passt
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
slot_hoehe = 30; //<50
slot_tiefe = 10;
slot_verdecken = 10; // TODO

steg_links_breite = 015; // TODO messen wenn linke Abdeckung drauf
steg_links_hoehe  = wand_monitor+mon_hoehe+wand_monitor; // 

module steg_rechts() {
    //Hauptplatte rechts
    translate([0-wand, 0-wand, 0-z_delta_schlitze_slot-wand-slot_verdecken])
    cube([  slot_breite+wand-wand,
            wand,
            z_delta_schlitze_slot+wand+slot_verdecken+haken_breite/2+haken_hoehe
    ]);

    difference(){ // Verstaerkung rechts
    translate([ 0+slot_breite-steg_links_breite/2,
                0,
                0-z_delta_schlitze_slot-haken_grip_hoehe-wand-slot_hoehe])
    cylinder(   h=  slot_hoehe+wand+haken_grip_hoehe+z_delta_schlitze_slot
                    +haken_breite/2+haken_hoehe,
                d=steg_links_breite, $fn=detail*4);
    
    translate([ 0,0, -300])
    cube([111,steg_links_breite,400]);
    }//diference
    
    
}//module steg_rechts
translate([0, 0, 0])
steg_rechts();

module steg_links() {
    intersection(){
        //rotate([-90,0,0])
        translate([0-steg_links_breite/2, 0, 0-steg_links_hoehe])
        cylinder(   h=steg_links_hoehe+haken_breite/2+haken_hoehe,
                    d=steg_links_breite, $fn=detail*4);
        translate([0-steg_links_breite, 0-steg_links_breite, 0-steg_links_hoehe])
        cube([steg_links_breite+wand, steg_links_breite, steg_links_hoehe+haken_breite/2+haken_hoehe]);
    } //intersection

        translate([wand+0-steg_links_breite, 0-wand, 0-haken_breite/2-haken_hoehe-z_delta_schlitze_slot-slot_hoehe])
        cube([0-wand+steg_links_breite+wand, wand,
                0+haken_breite/2+haken_hoehe+z_delta_schlitze_slot+slot_hoehe]);
        
}//module steg_links
translate([0, 0, 0])
steg_links();

abstand_monitor=10;
module Monitorhalter(){
    //cylinder(h=wand, d=zapfen_durchmesser);
    difference(){ //Halter oben
        translate([0-mon_dicke/2, 0-mon_dicke/2, 0])
        cube([mon_dicke,mon_dicke+steg_links_breite/2+abstand_monitor, wand_monitor]);        
        translate([0, 0, 0])
        cylinder(h=wand_monitor, d=zapfen_durchmesser, $fn=detail);
    }//difference    
    
        //Halter unten
        translate([0-mon_dicke/2, 0-mon_dicke/2, -mon_hoehe-wand_monitor])
        cube([mon_dicke,mon_dicke+steg_links_breite/2+abstand_monitor, wand_monitor]);        
        //Halter unten
        translate([0, 0, -mon_hoehe])
        cylinder(h=zapfen_hoehe, d1=zapfen_durchmesser, d2=zapfen_durchmesser*0.8, $fn=detail);
    
}//Monitorhalter
translate([
    0-2.5-(steg_links_breite-wand)/2,
    0-mon_dicke/2-(steg_links_breite/2)-abstand_monitor,
    0-wand_monitor
    ])
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
 
    slot_verdecken_rechts = 20;
    translate([slot_breite-slot_verdecken_rechts, 0-wand, 0])
    cube([slot_verdecken_rechts-wand, wand+slot_tiefe, slot_hoehe]); //slot wand rechts   
}
translate([0,0, -z_delta_schlitze_slot -slot_hoehe -wand -haken_grip_hoehe])
slot();

module hakenreihe() {
    haken_breite_delta_halb = (haken_breite - haken_breite_druck) / 2;
    for (i = [0 : (anzahl_haken+2) - 1]) {
        //aussenseite
        translate([i * haken_abstand, 0, 0+haken_breite/2])
            cube([haken_breite_druck, haken_tiefe, haken_hoehe]);
        translate([i * haken_abstand + (haken_breite_druck/2), 0, 0+haken_breite/2])
        rotate([-90,0,0])
            cylinder(h=haken_tiefe, d=haken_breite_druck, $fn=detail/2);
        //innenseite Rastnasen
        translate([i * haken_abstand, haken_grip_tiefe, -haken_grip_hoehe+haken_breite_druck/2])
            cube([haken_breite_druck, haken_tiefe-haken_grip_tiefe, haken_hoehe+haken_grip_hoehe]);
        translate([i * haken_abstand + (haken_breite_druck/2), haken_grip_tiefe, -haken_grip_hoehe+haken_breite_druck/2])
        rotate([-90,0,0])
            cylinder(h=haken_tiefe-haken_grip_tiefe, d=haken_breite_druck, $fn=detail/2);
    }
}
translate([-haken_abstand*2,0, 0])
hakenreihe();
