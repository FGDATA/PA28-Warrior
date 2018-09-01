# PA28-161 Libraries
# Joshua Davidson (it0uchpods)

# doors ============================================================
rightDoor = aircraft.door.new("/sim/model/door-positions/rightDoor", 2, 0);

# reset compass rose rotation for the ki228
setlistener("/instrumentation/adf[0]/model", func(n) {
	if (n != nil) {
		var v = n.getValue();
		if (v != nil and v == "ki228")
		setprop("/instrumentation/adf[0]/rotation-deg", 0);
	}
}, 1, 0);

gui.Dialog.new("sim/gui/dialogs/windsim/dialog", "Aircraft/PA28-Warrior/Dialogs/windsim.xml");
gui.Dialog.new("sim/gui/dialogs/sounddialog/dialog", "Aircraft/PA28-Warrior/Dialogs/sounddialog.xml");

setlistener("/sim/sounde/switch1", func {
	if (!getprop("/sim/sounde/switch1")) {
		return;
	}
	settimer(func {
		props.globals.getNode("/sim/sounde/switch1").setBoolValue(0);
	}, 0.05);
});

setlistener("/sim/sounde/switch2", func {
	if (!getprop("/sim/sounde/switch2")) {
		return;
	}
	settimer(func {
		props.globals.getNode("/sim/sounde/switch2").setBoolValue(0);
	}, 0.05);
});

setlistener("/sim/sounde/switch3", func {
	if (!getprop("/sim/sounde/switch3")) {
		return;
	}
	settimer(func {
		props.globals.getNode("/sim/sounde/switch3").setBoolValue(0);
	}, 0.05);
});

setlistener("/sim/sounde/knob", func {
	if (!getprop("/sim/sounde/knob")) {
		return;
	}
	settimer(func {
		props.globals.getNode("/sim/sounde/knob").setBoolValue(0);
	}, 0.05);
});

var systemsInit = func {
	systems.ELEC.init();
	systems.ENG.init();
	systems.FUEL.init();
	itaf.ap_init();
	variousReset();
	var autopilot = gui.Dialog.new("sim/gui/dialogs/autopilot/dialog", "Aircraft/PA28-Warrior/Systems/kap140-dlg.xml");
	setprop("/it-autoflight/settings/slave-gps-nav", 0);
	setprop("/engines/engine[0]/fuel-flow-gph", 0.0);
	setprop("/sim/model/material/LandingLight/factor", 0.0);
	setprop("/sim/model/material/LandingLight/factorAGL", 0.0);
	systemsLoop.start();
}

setlistener("sim/signals/fdm-initialized", func {
	systemsInit();
});

var systemsLoop = maketimer(0.1, func {
	systems.ELEC.loop();
	systems.FUEL.loop();
});

var variousReset = func {
	setprop("/it-autoflight/input/hdg", getprop("/orientation/heading-magnetic-deg"));
	setprop("/it-autoflight/input/alt", 2000);
	setprop("/it-autoflight/settings/slave-gps-nav", 0);
	setprop("/controls/switches/beacon", 0);
	setprop("/controls/switches/fuel-pump", 0);
	setprop("/controls/switches/landing-light", 0);
	setprop("/controls/switches/nav-lights-factor", 0);
	setprop("/controls/switches/panel-lights-factor", 0);
	setprop("/controls/switches/pitot-heat", 0);
	setprop("/controls/switches/strobe-lights", 0);
	setprop("/controls/engines/engine[0]/magnetos-switch", 0);
	setprop("/controls/engines/engine[0]/mixture", 0);
	setprop("/fdm/jsbsim/extra/door-main-cmd", 0);
}

setlistener("/options/nav-source", func {
	if (getprop("/options/nav-source") == 1) {
		setprop("/it-autoflight/settings/use-nav2-radio", 0);
		setprop("/it-autoflight/settings/slave-gps-nav", 0);
	} else if (getprop("/options/nav-source") == 2) {
		setprop("/it-autoflight/settings/use-nav2-radio", 0);
		setprop("/it-autoflight/settings/slave-gps-nav", 1);
	} else if (getprop("/options/nav-source") == 3) {
		setprop("/it-autoflight/settings/use-nav2-radio", 1);
		setprop("/it-autoflight/settings/slave-gps-nav", 0);
	}
});

if (getprop("/controls/flight/auto-coordination") == 1) {
	setprop("/controls/flight/auto-coordination", 0);
	setprop("/controls/flight/aileron-drives-tiller", 1);
} else {
	setprop("/controls/flight/aileron-drives-tiller", 0);
}
