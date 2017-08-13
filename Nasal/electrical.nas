# PA28-161 Electrical
# (c) Joshua Davidson (it0uchpods)

#############
# Init Vars #
#############

var dc_volt_std = 28;
var dc_volt_min = 25;
var dc_amps_std = 35;

setlistener("/sim/signals/fdm-initialized", func {
	var batt_sw = getprop("/controls/electrical/battery");
	var alternator_sw = getprop("/controls/electrical/alternator");
	var rpm = getprop("/engines/engine[0]/rpm");
	var batt_volt = 12;
	var batt_amp = 35;
	var elec1 = 0;
	var elec2 = 0;
});

var elec_init = func {
	setprop("/controls/electrical/battery", 0);
	setprop("/controls/electrical/alternator", 0);
	setprop("/systems/electrical/batt-volt", 12);
	setprop("/systems/electrical/batt-amp", 35);
	setprop("/systems/electrical/bus/elec1", 0);
	setprop("/systems/electrical/bus/elec2", 0);
	elec_timer.start();
}

######################
# Main Electric Loop #
######################

var master_elec = func {
	batt_sw = getprop("/controls/electrical/battery");
	alternator_sw = getprop("/controls/electrical/alternator");
	rpm = getprop("/engines/engine[0]/rpm");
	batt_volt = getprop("/systems/electrical/batt-volt");
	batt_amp = getprop("/systems/electrical/batt-amp");
	elec1 = getprop("/systems/electrical/bus/elec1");
	elec2 = getprop("/systems/electrical/bus/elec2");
	
	if (getprop("/systems/electrical/bus/dc") < 25) {
		setprop("/it-autoflight/input/ap", 0);
		kap140.apLightTimer.start();
		setprop("systems/electrical/on", 0);
		setprop("/systems/electrical/outputs/adf", 0);
		setprop("/systems/electrical/outputs/audio-panel", 0);
		setprop("/systems/electrical/outputs/audio-panel[1]", 0);
		setprop("/systems/electrical/outputs/autopilot", 0);
		setprop("/systems/electrical/outputs/avionics-fan", 0);
		setprop("/systems/electrical/outputs/beacon", 0);
		setprop("/systems/electrical/outputs/bus", 0);
		setprop("/systems/electrical/outputs/cabin-lights", 0);
		setprop("/systems/electrical/outputs/dme", 0);
		setprop("/systems/electrical/outputs/efis", 0);
		setprop("/systems/electrical/outputs/flaps", 0);
		setprop("/systems/electrical/outputs/fuel-pump", 0);
		setprop("/systems/electrical/outputs/gps", 0);
		setprop("/systems/electrical/outputs/gps-mfd", 0);
		setprop("/systems/electrical/outputs/hsi", 0);
		setprop("/systems/electrical/outputs/instr-ignition-switch", 0);
		setprop("/systems/electrical/outputs/instrument-lights", 0);
		setprop("/systems/electrical/outputs/landing-lights", 0);
		setprop("/systems/electrical/outputs/map-lights", 0);
		setprop("/systems/electrical/outputs/mk-viii", 0);
		setprop("/systems/electrical/outputs/nav", 0);
		setprop("/systems/electrical/outputs/nav[1]", 0);
		setprop("/systems/electrical/outputs/pitot-head", 0);
		setprop("/systems/electrical/outputs/stobe-lights", 0);
		setprop("/systems/electrical/outputs/tacan", 0);
		setprop("/systems/electrical/outputs/taxi-lights", 0);
		setprop("/systems/electrical/outputs/transponder", 0);
		setprop("/systems/electrical/outputs/turn-coordinator", 0);
	} else {
		setprop("/systems/electrical/on", 1);
		setprop("/systems/electrical/outputs/adf", dc_volt_std);
		setprop("/systems/electrical/outputs/audio-panel", dc_volt_std);
		setprop("/systems/electrical/outputs/audio-panel[1]", dc_volt_std);
		setprop("/systems/electrical/outputs/autopilot", dc_volt_std);
		setprop("/systems/electrical/outputs/avionics-fan", dc_volt_std);
		setprop("/systems/electrical/outputs/beacon", dc_volt_std);
		setprop("/systems/electrical/outputs/bus", dc_volt_std);
		setprop("/systems/electrical/outputs/cabin-lights", dc_volt_std);
		setprop("/systems/electrical/outputs/dme", dc_volt_std);
		setprop("/systems/electrical/outputs/efis", dc_volt_std);
		setprop("/systems/electrical/outputs/flaps", dc_volt_std);
		setprop("/systems/electrical/outputs/fuel-pump", dc_volt_std);
		setprop("/systems/electrical/outputs/gps", dc_volt_std);
		setprop("/systems/electrical/outputs/gps-mfd", dc_volt_std);
		setprop("/systems/electrical/outputs/hsi", dc_volt_std);
		setprop("/systems/electrical/outputs/instr-ignition-switch", dc_volt_std);
		setprop("/systems/electrical/outputs/instrument-lights", dc_volt_std);
		setprop("/systems/electrical/outputs/landing-lights", dc_volt_std);
		setprop("/systems/electrical/outputs/map-lights", dc_volt_std);
		setprop("/systems/electrical/outputs/mk-viii", dc_volt_std);
		setprop("/systems/electrical/outputs/nav", dc_volt_std);
		setprop("/systems/electrical/outputs/nav[1]", dc_volt_std);
		setprop("/systems/electrical/outputs/pitot-head", dc_volt_std);
		setprop("/systems/electrical/outputs/stobe-lights", dc_volt_std);
		setprop("/systems/electrical/outputs/tacan", dc_volt_std);
		setprop("/systems/electrical/outputs/taxi-lights", dc_volt_std);
		setprop("/systems/electrical/outputs/transponder", dc_volt_std);
		setprop("/systems/electrical/outputs/turn-coordinator", dc_volt_std);
	}
}

###################
# Update Function #
###################

var update_electrical = func {
	master_elec();
}

var elec_timer = maketimer(0.2, update_electrical);