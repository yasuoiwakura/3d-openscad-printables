//use <../_round_edge.scad>;
_round_edge(r=3, l=10, test=1, axis="x", rot=0);

module _round_edge(r=10, l=1111, axis="z", x=1, y=1, rot=0, test=0, fn=128){
//    translate([x, y, z]) {
        // Rotation je nach Achse
//    rotate([0,0,0])
    sphere(test);

    rotate(
        axis == "x" ?   [rot, 0, 0] : 
        axis == "y" ?   [0, rot, 0] : 
                        [0, 0, rot]//z
    ){

    translate(
        axis == "x" ?   [l, -r, -r] : 
        axis == "y" ?   [-r, l, -r] : 
                        [-r, -r, 0]//z
    ){
        
    rotate(
        axis == "x" ?   [0, -90, 0] : 
        axis == "y" ?   [90, 0, 0] : 
                        [0, 0, 0]//z
    ){
    difference(){                   
        cube([r,r,l]);
        cylinder(h=l, r=r, $fn=fn);
    }//difference
    }//rotate axis=?
    }
    }//rotate rot=?
}//module