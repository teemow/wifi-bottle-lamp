// dimensions
base_length = 250;
base_width = 100;
base_thickness = 20;

bottle_holder_length = 200;
bottle_holder_width = 80;
bottle_holder_thickness = 20;
bottle_holder_angle = 20;

tube_diameter = 43;
tube_length = 120;
tube_thickness = 2;

bottle_diameter = 30;
bottle_offset = 11;

chip_length = 34;
chip_platform_offset = 6;
chip_platform_thickness = 4;

ring_thickness = 2;
ring_length = 2;
inner_ring_thickness = 3;
inner_ring_length = 5;
inner_length = 10;
front_plate_thickness = 2;
usb_hole = 6.5;

middle_length = 8;
middle_thickness = 1;
middle_ring_length = 1;
middle_ring_thickness = ring_thickness;

resolution = 100;

use <lib.scad>;

// base
minkowski() {
    cube(size = [base_length, base_width, base_thickness]);
    sphere(3);
}

// bottle holder
base_gold_cut = base_length/100*38;
base_center = base_width/2;
bottle_holder_gold_cut = bottle_holder_length/100*62;
bottle_holder_center = (base_width-bottle_holder_width)/2;
bottle_holder_offset = base_thickness-6;
translate([base_gold_cut,bottle_holder_center,bottle_holder_offset]) difference() {
    rotate([0,-bottle_holder_angle,0]) {
        minkowski() {
            cube(size = [bottle_holder_thickness, bottle_holder_width, bottle_holder_length]);
            cylinder(d=3,h=bottle_holder_thickness);
        }
    }
    
    translate([-bottle_holder_thickness,bottle_holder_width/2,bottle_holder_gold_cut]) rotate([0,-(90 + bottle_holder_angle),0]) {
        cylinder(d = tube_diameter, h = bottle_holder_thickness + 12, center = false, $fn = resolution);
    }
}

// tube
tube_gold_cut = tube_length/100*62;
tube_offset = tube_gold_cut * sin(bottle_holder_angle) + tube_thickness;
translate([base_gold_cut-bottle_holder_thickness+tube_gold_cut,base_center,bottle_holder_offset + bottle_holder_gold_cut + tube_offset]) rotate([0,-(90 + bottle_holder_angle),0]) {
    difference() {
        cylinder(d = tube_diameter, h = tube_length, center = false, $fn = resolution);
        cylinder(d = tube_diameter - tube_thickness, h = tube_length, center = false, $fn = resolution);
    }
}

// middle adapter
translate([base_gold_cut-bottle_holder_thickness,base_center,bottle_holder_offset + bottle_holder_gold_cut]) rotate([0,-(90 + bottle_holder_angle),0]) {
    translate([0,0,-tube_length]) middle(tube_diameter, middle_length, middle_thickness, middle_ring_length, middle_ring_thickness, resolution);
    rotate([0,180,0]) {
        translate([0,0,-tube_length/2-10]) middle(tube_diameter, middle_length, middle_thickness, middle_ring_length, middle_ring_thickness, resolution);
    }
}

// front + rear
translate([base_gold_cut-bottle_holder_thickness,base_center,bottle_holder_offset + bottle_holder_gold_cut]) rotate([0,-(90 + bottle_holder_angle),0]) {
    rotate([0,0,180]) {
        translate([0,0,-tube_length-50]) front(tube_diameter, tube_thickness, ring_thickness, ring_length, front_plate_thickness, inner_length, bottle_diameter, bottle_offset, resolution);
    }
    rotate([0,180,0]) {
        translate([0,0,-tube_length/2-60]) rear(tube_diameter, tube_thickness, ring_thickness, inner_ring_thickness, ring_length, inner_ring_length, front_plate_thickness, chip_length, chip_platform_offset, chip_platform_thickness, usb_hole, resolution);
    }
}