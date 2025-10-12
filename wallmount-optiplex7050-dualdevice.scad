// Parameter
wand_dicke = 5;  // Tiefe der Platten in mm (Y-Richtung)
d_loch = 4.5;  // Durchmesser der Bohrlöcher in mm
wand_abstand = 36;  // Abstand zwischen den Platten in mm (Y-Versatz)
optiplex_breite = 35.5;  // Breite des OptiPlex 7550 in mm
hdd_breite = 35.5;  // Breite des externen HDD-Gehäuses in mm

h_wand_1=150;
h_wand_2=30;
h_wand_3=30;
wand_hoehe = 50;  // Höhe der Platten in mm (Z-Richtung)
wand_laenge = 150;  // Länge der Platten in mm (X-Richtung)
h_halter = 50;  // Höhe der Platten in mm (Z-Richtung)
bohrloch_abstand = 10;  // Abstand der Bohrlöcher zur Kante der Platten
bodenplatte_dicke = 10;  // Dicke der Bodenplatte in mm

nase=10;

bohr_axis="y";

fn=128;
test=false;
export=0; // 0=alles 1=boden+Wandplatte 2=Wände  3=nur 1 Wand
do_text=true;

use <../_bohr_senk.scad>;
use <../_round_edge.scad>;
use <../_wall_with_holes.scad>;


if (export == 0 || export == 1){
    difference(){
        union(){
            if (export == 0 || export == 1){
                translate([0, 0, 0]) {
                    bodenplatte();  // Bodenplatte, die alle 3 Wände verbindet
                }
                translate([0, wand_dicke*2 +wand_abstand*2, bodenplatte_dicke]) {
                    wand_1(h=h_wand_1);  // Erste Wand für OptiPlex mit Senkkopfbohrungen
                }
            }}
        translate([0, 0, bodenplatte_dicke]) {
            wand_2_3(h=h_wand_3);  // Dritte Wand für HDD-Gehäuse (keine Bohrlöcher)
        }
        translate([0, wand_dicke+wand_abstand, bodenplatte_dicke]) {
            wand_2_3(h=h_wand_2);  // Zweite Wand zwischen HDD/Optiplex
        }
    }
};

if (export == 0 || export == 2|| export == 3){
        translate([0, 0, bodenplatte_dicke]) {
            wand_2_3(h=h_wand_3);  // Dritte Wand für HDD-Gehäuse (keine Bohrlöcher)
        }

        if (export != 3){
            translate([0, wand_dicke+wand_abstand, bodenplatte_dicke]) {
                wand_2_3(h=h_wand_2);  // Zweite Wand zwischen HDD/Optiplex
            }
        }
    }


if (test){
    // Platzhalter für den OptiPlex
    translate([1, wand_dicke*1 +wand_abstand*0+0.25, bodenplatte_dicke]) {
        color("red") {
            cube([190, hdd_breite, 115]);  // OptiPlex Platzhalter
        }}

    // Platzhalter für das HDD-Gehäuse
    translate([1, wand_dicke*2 +wand_abstand*1+0.25, bodenplatte_dicke]) {
        color("blue") {
            cube([180, optiplex_breite, 180]);  // HDD-Gehäuse Platzhalter
        }}
    }

// Halterung für Wand 1 (OptiPlex) mit Senkkopfbohrungen
module wand_1(h=wand_hoehe) {
    x_bohr_le=bohrloch_abstand;
    x_bohr_ri=wand_laenge - bohrloch_abstand;
    z_bohr_up=h_wand_1-bohrloch_abstand;
    z_bohr_dn=bohrloch_abstand;
    difference() {

        _wall_with_holes([wand_laenge, wand_dicke, h_wand_1]
        ,100,0,
        30, fn=fn);  // Wand 1 (für OptiPlex)
        // Senkkopfbohrungen für Wand 1 (nur bei Wand 1!)
        bohr_senk(x_bohr_le, 0, z_bohr_up, axis="y");  // 1. Senkkopfbohrung
        bohr_senk(x_bohr_ri, 0, z_bohr_up, axis="y");  // 2. Senkkopfbohrung
        bohr_senk(x_bohr_le, 0, z_bohr_dn, axis="y");
        bohr_senk(x_bohr_ri, 0, z_bohr_dn, axis="y");

        translate([0,0,h])
        _round_edge(r=wand_dicke, axis="x", rot=90, fn=fn*2);
        translate([0,0,0])
        _round_edge(r=0.5, axis="z", rot=180, fn=fn);
        translate([wand_laenge,0,0])
        _round_edge(r=0.5, axis="z", rot=-90, fn=fn);
            
        translate([wand_laenge/2,0,h*0.15])
            cylinder(h=h*0.7, d=h*0.6);

    };//diff

//    rotate([0,90,0])
//    cylinder(h=wand_laenge, d=wand_dicke, $fn=fn);
}


module wand_2_3(h=wand_hoehe) {  // (zwischen OptiPlex und HDD)
    union() {
        
        cube([wand_laenge, wand_dicke, h]); // Wand

        translate([0,wand_dicke/2-0.25,h]) // Abrundung
            rotate([0,90,0])
            cylinder(h=wand_laenge, d=wand_dicke+0.5, $fn=fn*2);
        
        translate([wand_laenge*1/3-nase/2,0,-bodenplatte_dicke])
            cube([nase,wand_dicke,bodenplatte_dicke]);
        translate([wand_laenge*2/3-nase/2,0,-bodenplatte_dicke])
            cube([nase,wand_dicke,bodenplatte_dicke]);
        
        
       if (do_text){
        txt_1 = "BLOX.MEDIA";
        txt_2 = "#SASU3D";
        h_txt=.5;
        // Text extrudieren
        rotate([90,0,0])
        color("blue"){
         translate([wand_laenge/2,10,0]){
          linear_extrude(height = h_txt) { 
           text(txt_1, size = 14, halign="center");
            }};
         translate([wand_laenge-5,2,0]){
          linear_extrude(height = h_txt/2) {
           text(txt_2, size = 6, halign="right");
        }};

        }//blue
       }//text


        
    }
}


module bodenplatte() { // die alle Wände unten verbindet
    union() {
        // Die Bodenplatte ist so groß, dass sie alle 3 Wände an der Unterseite berührt
        cube([wand_laenge, 2 * wand_abstand + 3* wand_dicke, bodenplatte_dicke]);  // Die Bodenplatte verbindet alle 3 Wände
        translate([0,0,bodenplatte_dicke/2])
        rotate([0,90,0])
        cylinder(h=wand_laenge, d=bodenplatte_dicke, $fn=fn*2);
    }
}
