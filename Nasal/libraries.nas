# PA28-161 Libraries
# Joshua Davidson (it0uchpods)

setlistener("/sim/signals/fdm-initialized", func {
	systems.elec_init();
	systems.engine_init();
	systems.fuel_init();
    itaf.ap_init();
    var autopilot = gui.Dialog.new("sim/gui/dialogs/autopilot/dialog", "Aircraft/PA28-Warrior/Systems/kap140-dlg.xml");
	setprop("/it-autoflight/input/hdg", getprop("/orientation/heading-magnetic-deg"));
	setprop("/it-autoflight/input/alt", 2000);
	setprop("/it-autoflight/settings/slave-gps-nav", 0);
    setprop("engines/engine[0]/fuel-flow-gph", 0.0);
    setprop("/surface-positions/flap-pos-norm", 0.0);
    setprop("/instrumentation/airspeed-indicator/indicated-speed-kt", 0.0);
    setprop("/instrumentation/airspeed-indicator/pressure-alt-offset-deg", 0.0);
    setprop("/accelerations/pilot-g", 1.0);
    setprop("/sim/model/material/LandingLight/factor", 0.0);  
    setprop("/sim/model/material/LandingLight/factorAGL", 0.0); 
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

var aglgears = func {
    var agl = getprop("/position/altitude-agl-ft") or 0;
    var aglft = agl - 3.32;  # is the position from the PA28-Warrior above ground
    var aglm = aglft * 0.3048;
    setprop("/position/gear-agl-ft", aglft);
    setprop("/position/gear-agl-m", aglm);

    settimer(aglgears, 0.01);
}

aglgears();