var val = 0;
var test = 0;
var toggle = 0;

var fuel_switch = func {
  node = props.globals.getNode("consumables/fuel/tank[0]/selected",0);
  node.setBoolValue(0);
  node = props.globals.getNode("consumables/fuel/tank[1]/selected",0);
  node.setBoolValue(0);

  val = getprop("controls/fuel/switch-position");
  test = 1 + val;
  if(test > 2){test=0};
  setprop("controls/fuel/switch-position",test);
  if(test == 1){
    node = props.globals.getNode("consumables/fuel/tank[0]/selected",0);
    node.setBoolValue(1);
    if(getprop("consumables/fuel/tank[0]/level-gal_us")>0.01){
      node = props.globals.getNode("engines/engine/out-of-fuel",1);
      node.setBoolValue(0);
    } 
  }
  if(test == 2){
    node = props.globals.getNode("consumables/fuel/tank[1]/selected",0);
    node.setBoolValue(1);
    if(getprop("consumables/fuel/tank[1]/level-gal_us")>0.01){
      node = props.globals.getNode("engines/engine/out-of-fuel",1);
      node.setBoolValue(0);
    } 
  }
}

fuel_switch();

var nav_light_switch = func {
  toggle=getprop("controls/switches/nav-lights");
  toggle=1-toggle;
  setprop("controls/switches/nav-lights",toggle);
}

var battery_switch = func {
  toggle=getprop("controls/electric/battery-switch");
  toggle=1-toggle;
  setprop("controls/electric/battery-switch",toggle);
  setprop("instrumentation/turn-indicator/serviceable",toggle);
}

var alternator_switch = func {
  toggle=getprop("controls/electric/alternator-switch");
  toggle=1-toggle;
  setprop("controls/electric/alternator-switch",toggle);
}

f_pump_switch = func {
toggle=getprop("controls/engines/engine/fuel-pump");
toggle=1-toggle;
setprop("controls/engines/engine/fuel-pump",toggle);
}

landing_light_switch = func {
toggle=getprop("controls/switches/landing-light");
toggle=1-toggle;
setprop("controls/switches/landing-light",toggle);
}

fin_strobe_light_switch = func {
toggle=getprop("controls/switches/flashing-beacon");
toggle=1-toggle;
setprop("controls/switches/flashing-beacon",toggle);
}

wing_strobe_light_switch = func {
toggle=getprop("controls/switches/strobe-lights");
toggle=1-toggle;
setprop("controls/switches/strobe-lights",toggle);
}

pitot_heat_switch = func {
toggle=getprop("controls/anti-ice/pitot-heat");
toggle=1-toggle;
setprop("controls/anti-ice/pitot-heat",toggle);
}

var panel_light_switch = func(c) {
  var factor=getprop("controls/switches/panel-lights-factor");
  if ( (c > 0) and ( factor > 1 )) { return; } 
  if ( (c < 0) and ( factor < 0 )) { return; }
  factor = c*0.01 + factor;
  setprop("controls/switches/panel-lights-factor",factor);
}

var carb_heat = func {
  toggle=getprop("controls/anti-ice/engine/carb-heat");
  toggle=1-toggle;
  setprop("controls/anti-ice/engine/carb-heat",toggle);
}

var primer = func {
  toggle=getprop("controls/engines/engine/primer-pump");
  toggle=1-toggle;
  setprop("controls/engines/engine/primer-pump",toggle);
}

var map_light_switch = func {
  toggle=getprop("controls/switches/map-lights");
  toggle=1-toggle;
  setprop("controls/switches/map-lights",toggle);
}

var cabin_light_switch = func {
  toggle=getprop("controls/switches/cabin-lights");
  toggle=1-toggle;
  setprop("controls/switches/cabin-lights",toggle);
}

var oat_switch = func {
  val = getprop("controls/switches/oat-switch");
  test = 1 + val;
  if(test > 2){test=0};
  setprop("controls/switches/oat-switch",test);
  settimer(oat_off, 300);
}

var oat_off = func {
  setprop("controls/switches/oat-switch",0);
}

var pa28_update = func {
  settimer(pa28_update, 0);
}

settimer(pa28_update, 0);

var sbc1 = aircraft.light.new( "sim/model/lights/sbc1", [0.5, 0.3] );
sbc1.interval = 0.1;
sbc1.switch( 1 );

var sbc2 = aircraft.light.new( "sim/model/lights/sbc2", [0.2, 0.3], "sim/model/lights/sbc1/state" );
sbc2.interval = 0;
sbc2.switch( 1 );

setlistener( "sim/model/lights/sbc2/state", func(n) {
  var bsbc1 = sbc1.stateN.getValue();
  var bsbc2 = n.getBoolValue();
  var b = 0;
  if( bsbc1 and bsbc2 and getprop( "controls/lighting/beacon") ) {
    b = 1;
  } else {
    b = 0;
  }
  setprop( "sim/model/lights/beacon/enabled", b );

  if( bsbc1 and !bsbc2 and getprop( "controls/lighting/strobe" ) ) {
    b = 1;
  } else {
    b = 0;
  }
  setprop( "sim/model/lights/strobe/enabled", b );
});

var beacon = aircraft.light.new( "sim/model/lights/beacon", [0.05, 0.05] );
beacon.interval = 0;

var strobe = aircraft.light.new( "sim/model/lights/strobe", [0.05, 0.05] );
strobe.interval = 0;

var DMESources = {
  1 : "/instrumentation/nav[0]/frequencies/selected-mhz",
  2 : "/instrumentation/dme/frequencies/selected-mhz",
  3 : "/instrumentation/nav[1]/frequencies/selected-mhz"
};

setlistener( "/instrumentation/dme/switch-position", func(n) {
  var v = n.getValue();
  v == nil and return;
  n.getParent().getNode( "frequencies/source", 1 ).setValue(DMESources[v]);
}, 1, 0 );


