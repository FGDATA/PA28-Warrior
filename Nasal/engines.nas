# PA28-161 Engine
# Copyright (c) 2017 Joshua Davidson (it0uchpods)

#############
# Init Vars #
#############

var magnetos = getprop("/controls/engines/engine[0]/magnetos");
var switch = getprop("/controls/engines/engine[0]/magnetos-switch");
var rpm = getprop("/engines/engine[0]/rpm");

var engine_init = func {
	setprop("/controls/engines/engine[0]/magnetos-switch", 0);
	setprop("/controls/engines/engine[0]/magnetos", 0);
	setprop("/controls/engines/engine[0]/starter", 0);
}

########################
# Starter and Magnetos #
########################

setlistener("/controls/engines/engine[0]/magnetos-switch", func {
	magnetoStartSwitch();
});

setlistener("/systems/electrical/bus/elec1", func {
	magnetoStartSwitch();
});

setlistener("/systems/electrical/bus/elec2", func {
	magnetoStartSwitch();
});

var magnetoStartSwitch = func {
	switch = getprop("/controls/engines/engine[0]/magnetos-switch");
	rpm = getprop("/engines/engine[0]/rpm");
	if (getprop("/systems/electrical/bus/elec1") >= 8 or getprop("/systems/electrical/bus/elec2") >= 8 or rpm >= 363) {
		if (switch == 0) {
			setprop("/controls/engines/engine[0]/magnetos", 0);
			setprop("/controls/engines/engine[0]/starter", 0);
		} else if (switch == 1) {
			setprop("/controls/engines/engine[0]/magnetos", 1);
			setprop("/controls/engines/engine[0]/starter", 0);
		} else if (switch == 2) {
			setprop("/controls/engines/engine[0]/magnetos", 2);
			setprop("/controls/engines/engine[0]/starter", 0);
		} else if (switch == 3) {
			setprop("/controls/engines/engine[0]/magnetos", 3);
			setprop("/controls/engines/engine[0]/starter", 0);
		} else if (switch == 4) {
			setprop("/controls/engines/engine[0]/magnetos", 3);
			setprop("/controls/engines/engine[0]/starter", 1);
		}
	} else {
		setprop("/controls/engines/engine[0]/magnetos", 0);
		setprop("/controls/engines/engine[0]/starter", 0);
	}
}