tube_diameter = 43;
tube_thickness = 2;
bottle_diameter = 30;
bottle_offset = 11;

ring_thickness = 2;
ring_length = 2;
front_plate_thickness = 2;
inner_length = 10;
resolution = 100;

use <lib.scad>;

front(tube_diameter, tube_thickness, ring_thickness, ring_length, front_plate_thickness, inner_length, bottle_diameter, bottle_offset, resolution);