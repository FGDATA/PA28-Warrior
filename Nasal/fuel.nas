# PA28-161 Fuel
# Copyright (c) 2018 Joshua Davidson (it0uchpods)

#############
# Init Vars #
#############

setlistener("/sim/signals/fdm-initialized", func {
	var rpm = getprop("/engines/engine[0]/rpm");
	var starter = getprop("/controls/engines/engine[0]/starter");
	var elec_pump = 0;
});

var fuel_init = func {
	setprop("/systems/fuel/selected-tank", 1);
	setprop("/controls/switches/fuel-pump", 0);
	setprop("/systems/fuel/suck-psi", 0);
	setprop("/systems/fuel/pump-psi", 0);
	setprop("/fdm/jsbsim/fuel/pump-psi-feedback", 0);
	setprop("/fdm/jsbsim/fuel/suck-psi-feedback", 0);
	fuel_timer.start();
}

##################
# Main Fuel Loop #
##################

var master_fuel = func {
	rpm = getprop("/engines/engine[0]/rpm");
	elec_pump = getprop("/systems/electrical/outputs/fuel-pump");
	starter = getprop("/controls/engines/engine[0]/starter");
	
	if (elec_pump >= 8 or rpm >= 421 or starter) {
		setprop("/systems/fuel/suck-fuel", 1);
	} else {
		setprop("/systems/fuel/suck-fuel", 0);
	}
}

###################
# Update Function #
###################

var update_fuel = func {
	master_fuel();
}

var fuel_timer = maketimer(0.1, update_fuel);
