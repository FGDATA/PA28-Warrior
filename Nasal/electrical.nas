# PA28-161 Electrical
# Copyright (c) 2017 Joshua Davidson (it0uchpods)

#############
# Init Vars #
#############

setprop("/systems/electrical/bus/elec1", 0);
setprop("/systems/electrical/bus/elec2", 0);
setprop("/systems/electrical/outputs/stby", 0);
setprop("/sim/menubar/default/menu[5]/item[4]/enabled", 0);

setlistener("/sim/signals/fdm-initialized", func {
	var batt_sw = getprop("/controls/electrical/battery");
	var altn_sw = getprop("/controls/electrical/alternator");
	var avionics_master = getprop("/controls/switches/avionics-master");
	var rpm = getprop("/engines/engine[0]/rpm");
	var src = "XX";
	var batt_volt = 12;
	var batt_amp = 35;
	var altn_volt = 0;
	var altn_amp = 0;
	var elec1 = 0;
	var elec2 = 0;
	var avionics1 = 0;
	var avionics2 = 0;
	var nav_factor = 0;
	var panel_factor = 0;
});

var elec_init = func {
	setprop("/controls/electrical/battery", 0);
	setprop("/controls/electrical/alternator", 0);
	setprop("/controls/switches/avionics-master", 0);
	src = "XX";
	setprop("/systems/electrical/batt-volt", 12);
	setprop("/systems/electrical/batt-amp", 35);
	setprop("/systems/electrical/altn-volt", 0);
	setprop("/systems/electrical/altn-amp", 0);
	setprop("/systems/electrical/bus/elec1", 0);
	setprop("/systems/electrical/bus/elec2", 0);
	setprop("/systems/electrical/bus/avionics1", 0);
	setprop("/systems/electrical/bus/avionics2", 0);
	setprop("/controls/switches/nav-lights-factor", 0);
	setprop("/controls/switches/panel-lights-factor", 0);
	elec_timer.start();
}

######################
# Main Electric Loop #
######################

var master_elec = func {
	batt_sw = getprop("/controls/electrical/battery");
	altn_sw = getprop("/controls/electrical/alternator");
	rpm = getprop("/engines/engine[0]/rpm");
	batt_volt = getprop("/systems/electrical/batt-volt");
	batt_amp = getprop("/systems/electrical/batt-amp");
	elec1 = getprop("/systems/electrical/bus/elec1");
	elec2 = getprop("/systems/electrical/bus/elec2");
	
	if (rpm >= 421 and altn_sw) {
		setprop("/systems/electrical/altn-volt", 14);
		setprop("/systems/electrical/altn-amp", 35);
	} else {
		setprop("/systems/electrical/altn-volt", 0);
		setprop("/systems/electrical/altn-amp", 0);
	}
	
	altn_volt = getprop("/systems/electrical/altn-volt");
	altn_amp = getprop("/systems/electrical/altn-amp");
	
	if (altn_volt >= 8 and altn_sw) {
		src = "ALTN";
		if (elec1 != altn_volt) {
			setprop("/systems/electrical/bus/elec1", altn_volt);
			setprop("/systems/electrical/bus/elec2", altn_volt);
		}
	} else if (batt_volt >= 8 and batt_sw) {
		src = "BATT";
		if (elec1 != batt_volt) {
			setprop("/systems/electrical/bus/elec1", batt_volt);
			setprop("/systems/electrical/bus/elec2", batt_volt);
		}
	} else {
		src = "XX";
		if (elec1 != 0) {
			setprop("/systems/electrical/bus/elec1", 0);
			setprop("/systems/electrical/bus/elec2", 0);
		}
	}
	
	avionics_master = getprop("/controls/switches/avionics-master");
	elec1 = getprop("/systems/electrical/bus/elec1");
	elec2 = getprop("/systems/electrical/bus/elec2");
	
	setprop("/systems/electrical/outputs/cabin-lights", elec1);
	setprop("/systems/electrical/outputs/map-lights", elec1);
	
	if (elec1 >= 8 and getprop("/controls/switches/fuel-pump") == 1) {
		setprop("/systems/electrical/outputs/fuel-pump", elec1);
	} else {
		setprop("/systems/electrical/outputs/fuel-pump", 0);
	}
	
	if (elec1 >= 8 and getprop("/controls/switches/beacon") == 1) {
		setprop("/controls/lighting/beacon", 1);
	} else {
		setprop("/controls/lighting/beacon", 0);
	}
	
	if (elec1 >= 8 and getprop("/controls/switches/strobe-lights") == 1) {
		setprop("/controls/lighting/strobe", 1);
	} else {
		setprop("/controls/lighting/strobe", 0);
	}
	
	if (elec1 >= 8 and getprop("/controls/switches/landing-light") == 1) {
		setprop("/controls/lighting/landing-lights", 1);
	} else {
		setprop("/controls/lighting/landing-lights", 0);
	}
	
	setprop("/systems/electrical/outputs/turn-coordinator", elec2);
	
	if (elec2 >= 8 and getprop("/controls/switches/nav-lights-factor") >= 0.1) {
		nav_factor = getprop("/controls/switches/nav-lights-factor");
		setprop("/controls/lighting/nav-lights", nav_factor);
	} else {
		setprop("/controls/lighting/nav-lights", 0);
	}
	
	if (elec2 >= 8 and getprop("/controls/switches/panel-lights-factor") >= 0.1) {
		panel_factor = getprop("/controls/switches/panel-lights-factor");
		setprop("/controls/lighting/panel-lights", panel_factor);
		setprop("/systems/electrical/outputs/instrument-lights", elec2);
		setprop("/sim/model/material/instruments/factor", elec2 * 0.071428571 * panel_factor);
		setprop("/systems/electrical/outputs/instrument-lights-norm", elec2 * 0.071428571 * panel_factor);
	} else {
		setprop("/controls/lighting/panel-lights", 0);
		setprop("/systems/electrical/outputs/instrument-lights", 0);
		setprop("/sim/model/material/instruments/factor", 0);
		setprop("/systems/electrical/outputs/instrument-lights-norm", 0);
	}
	
	if (elec2 >= 8 and getprop("/controls/switches/pitot-heat") == 1) {
		setprop("/systems/electrical/outputs/pitot-heat", elec2);
	} else {
		setprop("/systems/electrical/outputs/pitot-heat", 0);
	}
	
	if (avionics_master) {
		setprop("/systems/electrical/bus/avionics1", elec1);
		setprop("/systems/electrical/bus/avionics2", elec2);
	} else {
		setprop("/systems/electrical/bus/avionics1", 0);
		setprop("/systems/electrical/bus/avionics2", 0);
	}
	
	setprop("/systems/electrical/outputs/annunciators", elec2);
	
	avionics1 = getprop("/systems/electrical/bus/avionics1");
	avionics2 = getprop("/systems/electrical/bus/avionics2");

	setprop("/systems/electrical/outputs/comm[0]", avionics1);
	setprop("/systems/electrical/outputs/hsi", avionics1);
	setprop("/systems/electrical/outputs/nav[0]", avionics1);
	setprop("/systems/electrical/outputs/oat", avionics1);
	setprop("/systems/electrical/outputs/dme", avionics1);
	setprop("/systems/electrical/outputs/stby", avionics1);
	
	setprop("/systems/electrical/outputs/adf", avionics2);
	setprop("/systems/electrical/outputs/autopilot", avionics2);
	setprop("/systems/electrical/outputs/comm[1]", avionics2);
	setprop("/systems/electrical/outputs/nav[1]", avionics2);
	setprop("/systems/electrical/outputs/transponder", avionics2);
}

###################
# Update Function #
###################

var update_electrical = func {
	master_elec();
}

var elec_timer = maketimer(0.2, update_electrical);
