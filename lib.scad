module middle(tube_diameter, adapter_length, adapter_thickness, ring_length, ring_thickness, resolution) {
    difference() {
        cylinder(d = tube_diameter, h = adapter_length, center = false, $fn = resolution);
        cylinder(d = tube_diameter - adapter_thickness, h = adapter_length, center = false, $fn = resolution);
    }

    difference() {
        cylinder(d = tube_diameter + ring_thickness, h = ring_length, center = false, $fn = resolution);
        cylinder(d = tube_diameter - adapter_thickness, h = ring_length, center = false, $fn = resolution);
    }
}

module front(tube_diameter, tube_thickness, ring_thickness, ring_length, front_plate_thickness, inner_length, bottle_diameter, bottle_offset, resolution) {
    difference() {
        cylinder(d = tube_diameter + ring_thickness, h = ring_length + front_plate_thickness, center = true, $fn = resolution);
        translate([0,0,front_plate_thickness/2]) 
            cylinder(d = tube_diameter, h = ring_length, center = true, $fn = resolution);
        translate([bottle_offset/2,0,-front_plate_thickness/2]) 
            cylinder(d = bottle_diameter, h = front_plate_thickness, center = true, $fn = resolution);
    }

    translate([0,0,(ring_length-front_plate_thickness)/2]) difference() {
        translate([0,0,inner_length/2]) 
            cylinder(d = tube_diameter - tube_thickness - 2, h = inner_length, center = true, $fn = resolution);
        translate([bottle_offset/2,0,inner_length/2]) 
            cylinder(d = bottle_diameter, h = inner_length, center = true, $fn = resolution);
    }
}

module rear(tube_diameter, tube_thickness, ring_thickness, inner_ring_thickness, ring_length, inner_ring_length, front_plate_thickness, chip_length, chip_platform_offset, chip_platform_thickness, usb_hole, resolution) {
    // ring and usb hole
    difference() {
        cylinder(d = tube_diameter + ring_thickness, h = ring_length + front_plate_thickness, center = true, $fn = resolution);
        
        translate([0,0,front_plate_thickness/2]) 
            cylinder(d = tube_diameter, h = ring_length, center = true, $fn = resolution);
        
        // usb hole
        translate([usb_hole/2,usb_hole/2,-front_plate_thickness/2]) 
            cylinder(d = usb_hole, h = front_plate_thickness, center = true, $fn = resolution);
        translate([usb_hole/2,-usb_hole/2,-front_plate_thickness/2]) 
            cylinder(d = usb_hole, h = front_plate_thickness, center = true, $fn = resolution);
        translate([usb_hole/2,0,-front_plate_thickness/2]) 
            cube(usb_hole, center = true);
    }

    // inner ring and chip platform
    difference() {
        inner_ring_remover_size = (chip_length < (tube_diameter - tube_thickness)) ? tube_diameter - tube_thickness : chip_length;
        inner_ring_remover_offset =  (usb_hole < chip_platform_offset) ? usb_hole : chip_platform_offset;

        // inner ring
        translate([0,0,chip_length/2]) 
            cylinder(d = tube_diameter - tube_thickness, h = chip_length, center = true, $fn = resolution);
        difference() {
            translate([0,0,chip_length/2]) 
                cylinder(d = tube_diameter - tube_thickness - inner_ring_thickness, h = chip_length, center = true, $fn = resolution);

            // chip platform
            translate([(tube_diameter - tube_thickness)/2 + chip_platform_offset,0,inner_ring_remover_size/2]) 
                cube(inner_ring_remover_size, center = true); 
        }
        
        // chip platform ring
        translate([0,0,chip_length/2]) 
            cylinder(d = tube_diameter - tube_thickness - inner_ring_thickness - chip_platform_thickness, h = chip_length, center = true, $fn = resolution);

        // upper inner ring thickness
        translate([-inner_ring_remover_size/2 + inner_ring_remover_offset/2,0,inner_ring_remover_size/2 + inner_ring_length])
            cube(inner_ring_remover_size, center = true);

        // inner ring recess
        translate([-inner_ring_remover_offset/2 + inner_ring_remover_offset/2,(inner_ring_remover_size - inner_ring_thickness)/2,inner_ring_remover_offset/2+1]) 
            cube(inner_ring_remover_offset, center = true);
        translate([-inner_ring_remover_offset/2 + inner_ring_remover_offset/2,-(inner_ring_remover_size - inner_ring_thickness)/2,inner_ring_remover_offset/2+1]) 
            cube(inner_ring_remover_offset, center = true);
    }
}