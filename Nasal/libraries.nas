# PA28-161 Libraries
# Joshua Davidson (it0uchpods)

setlistener("/sim/signals/fdm-initialized", func {
	systems.elec_init();
	systems.engine_init();
	systems.fuel_init();
    itaf.ap_init();
    var autopilot = gui.Dialog.new("sim/gui/dialogs/autopilot/dialog", "Aircraft/FGNavigator1/Systems/kap140-dlg.xml");
	setprop("/it-autoflight/input/hdg", getprop("/orientation/heading-magnetic-deg"));
	setprop("/it-autoflight/input/alt", 2000);
	setprop("/it-autoflight/settings/slave-gps-nav", 1);
    setprop("engines/engine[0]/fuel-flow-gph", 0.0);
    setprop("/surface-positions/flap-pos-norm", 0.0);
    setprop("/instrumentation/airspeed-indicator/indicated-speed-kt", 0.0);
    setprop("/instrumentation/airspeed-indicator/pressure-alt-offset-deg", 0.0);
    setprop("/accelerations/pilot-g", 1.0);
    setprop("/sim/model/material/LandingLight/factor", 0.0);  
    setprop("/sim/model/material/LandingLight/factorAGL", 0.0); 
});  
