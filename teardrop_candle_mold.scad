// Teardrop Candle Mold (2-part)
// Community share – Christmas edition 🎄
// Units: millimeters

$fn = 120;

// -------- Parameters --------
candle_height = 90;
max_width = 55;
wall_thickness = 4;
mold_thickness = 18;
wick_hole_dia = 2.5;
alignment_pin_dia = 6;
alignment_pin_depth = 4;

// -------- Teardrop Shape --------
module teardrop() {
    scale([1,1,1.2])
    rotate_extrude()
    translate([max_width/4,0,0])
    circle(r=max_width/4);
}

// -------- Candle Core --------
module candle_core() {
    difference() {
        teardrop();
        // Wick hole
        translate([0,0,candle_height-5])
            cylinder(h=20, d=wick_hole_dia, center=false);
    }
}

// -------- Mold Half --------
module mold_half(mirror_side=false) {
    mirror(mirror_side ? [1,0,0] : [0,0,0])
    difference() {
        // Outer mold block
        translate([-max_width/2 - mold_thickness/2, -max_width/2, 0])
        cube([max_width + mold_thickness, max_width, candle_height + 10]);

        // Candle cavity
        translate([0,0,5])
            candle_core();

        // Split cut
        translate([0,-max_width,0])
            cube([max_width, max_width*2, candle_height+20]);

        // Alignment pin holes
        for (z=[25,60]) {
            translate([-max_width/2, max_width/4, z])
                cylinder(h=alignment_pin_depth, d=alignment_pin_dia);
        }
    }
}

// -------- Assembly View --------
mold_half(false);
translate([max_width + 4,0,0])
    mold_half(true);
