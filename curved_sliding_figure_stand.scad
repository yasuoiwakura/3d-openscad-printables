// Modul: aussparung
// Erzeugt einen gebogenen Balken (Radius 1m) mit radialer Breite delta_r und Hoehe schiene_tiefe, zentriert.

// Parameter
schiene_laenge  = 70;          // Radiale Breite der Aussparung (mm)
schiene_hoehe   = 10;   // Hoehe des Balkens (mm)
schiene_tiefe   = 13;
monitor_radius  = 1000;  // Radius der Biegung (mm)

stab_versatz_nach_rechts = 0; // nur fuer Sichtpruefung
stab_versatz_nach_rechts = -15; // Schwerpunkt der 30mm breiten Figur in die Mitte bringen

stab_dia        = 2.8;
stab_hoehe      = 35;
stab_seitlich   = 9;
stab_ausparung_laenge = 1.5;

wand=2;
fn = 128;               // $fn Aufloesung fuer Boegen
//fn = 16;               // $fn Aufloesung fuer Boegen
//fn=fn*10;

module bogen(
    tiefe, wand_vorne=0, wand_oben=0, schraege_hinten=0, delta_laenge=0
    ,center=true
    ) {

    angle = (schiene_laenge+delta_laenge) / monitor_radius * 180 / PI;  // Biegung

    delta_rotate = center ? angle/2 : 0;
    //delta_y = center ? -(2+13+2)/2 : 0;
    delta_y = center ? ( -(wand+schiene_tiefe+wand)/2 ) : 0;

    translate([0,-monitor_radius+wand_vorne+delta_y,-schiene_hoehe-wand_oben])
    rotate([0,0,90-delta_rotate])
    rotate_extrude(angle = angle, $fn=fn*40)
        translate([monitor_radius, 0])
                union(){
                    square([tiefe, schiene_hoehe], center = false);
                    polygon(points=[
                        [tiefe,  schiene_hoehe],
                        [tiefe, 0],
                        [tiefe+schraege_hinten, 0]
                    ]
                    //,center = false
                    );
                };
}

module schiene(){
    translate([0,0,0])
    difference(){ // Schiene
    translate([0,0,0])
        bogen(13+2+5);
        
    translate([0,0,0])
        bogen(  schiene_tiefe,
                wand_vorne=wand, wand_oben=wand,
                delta_laenge=1,
                schraege_hinten=5
        );//*/
    }}


module hangman(){
    translate([-stab_seitlich,0,0-wand])
    cylinder(h=stab_hoehe+wand, d=stab_dia, $fn=fn);

    difference(){
        translate([0-stab_seitlich,0,stab_hoehe])
        rotate([0,90,0])
            cylinder(h=stab_seitlich, d=stab_dia, $fn=fn);

        translate([-stab_ausparung_laenge,-stab_dia/2,stab_hoehe-stab_dia/2])
        cube([stab_ausparung_laenge+0.01,stab_dia, stab_dia/2]);
        }

    translate([-stab_seitlich,0,stab_hoehe])
    sphere(d=stab_dia, $fn=fn);
    }

module main(){
    difference(){
        translate([0,0,0])
        schiene();

        translate([-stab_versatz_nach_rechts,0,-wand*2])
        cylinder(h=wand*3, d=stab_dia, $fn=fn);
    }
        
    //hangman();
    translate([stab_versatz_nach_rechts,0,0])
    hangman();
}    
    
translate([0,0,0])
main();