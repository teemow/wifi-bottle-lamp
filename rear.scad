resolution = 100;
tube_diameter = 32;
tube_thickness = 1.5;

ring_thickness = 2;
inner_ring_thickness = 3;
ring_length = 2;
inner_ring_length = 5;
front_plate_thickness = 2;

chip_length = 34;
chip_platform_offset = 6;
chip_platform_thickness = 4;
usb_hole = 6.5;

use <lib.scad>;

rear(tube_diameter, tube_thickness, ring_thickness, inner_ring_thickness, ring_length, inner_ring_length, front_plate_thickness, chip_length, chip_platform_offset, chip_platform_thickness, usb_hole, resolution);
