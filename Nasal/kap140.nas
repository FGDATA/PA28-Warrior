# KAP140 Autopilot System
# IT-AUTOFLIGHT:GA System
# Tries to make ITAF:GA behave like Bendex-King KAP140 Two-Axis with Altitude Preselect
# Joshua Davidson (it0uchpods)

########
# Init #
########

setlistener("/sim/signals/fdm-initialized", func {
	trimLightTimer.start();
});

#####################
# Buttons and Knobs #
#####################

var btnHDG = func {
	if (getprop("/it-autoflight/output/lat") == 0) {
		setprop("/it-autoflight/input/lat", 1);
	} else {
		setprop("/it-autoflight/input/lat", 0);
	}
}

var btnNAV = func {
	var lat = getprop("/it-autoflight/output/lat");
	if (getprop("/it-autoflight/output/appr-armed") == 0) {
		if ((lat == 0 or lat == 1) and (getprop("/it-autoflight/output/loc-armed")) == 0) {
			setprop("/it-autoflight/input/lat", 2);
		} else if ((lat == 0 or lat == 1) and (getprop("/it-autoflight/output/loc-armed")) == 1) {
			setprop("/it-autoflight/input/lat", lat);
		} else if (lat == 2) {
			setprop("/it-autoflight/input/lat", 1);
		}
	}
}

var btnREV = func {
	# REV is not working yet, so just popup a msg.
	gui.popupTip("REV Mode is not finished yet. Nothing has been armed.");
}

var btnARM = func {
	if (getprop("/it-autoflight/output/alt-arm") == 1) {
		setprop("/it-autoflight/input/alt-arm", 0);
	} else {
		setprop("/it-autoflight/input/alt-arm", 1);
	}
}

var btnALT = func {
	if (getprop("/it-autoflight/output/vert") == 0) {
		setprop("/it-autoflight/input/alt-arm", 0);
		setprop("/it-autoflight/input/vert", 1);
	} else {
		setprop("/it-autoflight/input/vert", 0);
	}
}

var btnAPR = func {
	var lat = getprop("/it-autoflight/output/lat");
	var vert = getprop("/it-autoflight/output/vert");
	if ((lat == 0 or lat == 1) and (vert == 0 or vert == 1) and (getprop("/it-autoflight/output/appr-armed")) == 0) {
		setprop("/it-autoflight/input/vert", 2);
	} else if ((lat == 0 or lat == 1) and (vert == 0 or vert == 1) and (getprop("/it-autoflight/output/appr-armed")) == 1) {
		setprop("/it-autoflight/input/lat", lat);
	} else if (lat == 2) {
		setprop("/it-autoflight/input/lat", 1);
	}
	if (vert == 2) {
		setprop("/it-autoflight/input/vert", 1);
	}
}

var btnDown = func {
	if (getprop("/it-autoflight/output/ap") == 1) {
		if (getprop("/it-autoflight/output/vert") != 1) {
			setprop("/it-autoflight/input/vert", 1);
		}
		setprop("/it-autoflight/kap140/display-mode", "VS");
		settimer(func{
			setprop("/it-autoflight/kap140/display-mode", "ALT");
		}, 3);
		setprop("/it-autoflight/input/vs", getprop("/it-autoflight/input/vs") - 100);
	}
}

var btnUp = func {
	if (getprop("/it-autoflight/output/ap") == 1) {
		if (getprop("/it-autoflight/output/vert") != 1) {
			setprop("/it-autoflight/input/vert", 1);
		}
		setprop("/it-autoflight/kap140/display-mode", "VS");
		settimer(func{
			setprop("/it-autoflight/kap140/display-mode", "ALT");
		}, 3);
		setprop("/it-autoflight/input/vs", getprop("/it-autoflight/input/vs") + 100);
	}
}

var knbSmallDown = func {
	if (getprop("/it-autoflight/output/ap") == 1) {
		setprop("/it-autoflight/input/alt", getprop("/it-autoflight/input/alt") - 100);
	}
}

var knbSmallUp = func {
	if (getprop("/it-autoflight/output/ap") == 1) {
		setprop("/it-autoflight/input/alt", getprop("/it-autoflight/input/alt") + 100);
	}
}

var knbLargeDown = func {
	if (getprop("/it-autoflight/output/ap") == 1) {
		setprop("/it-autoflight/input/alt", getprop("/it-autoflight/input/alt") - 500);
	}
}

var knbLargeUp = func {
	if (getprop("/it-autoflight/output/ap") == 1) {
		setprop("/it-autoflight/input/alt", getprop("/it-autoflight/input/alt") + 500);
	}
}

var btnBAROPush = func {
	setprop("/it-autoflight/kap140/display-mode", "BARO");
}

var btnBARORelease = func {
	setprop("/it-autoflight/kap140/display-mode", "ALT");
}

var btnAP = func {
	if (getprop("/it-autoflight/output/ap") == 1) {
		setprop("/it-autoflight/input/ap", 0);
		apLightTimer.start();
	} else {
		setprop("/it-autoflight/input/ap", 1);
	}
}

##########
# Lights #
##########

var trimLight = func {
	var status = getprop("/it-autoflight/kap140/pt");
	if (status == 0) {
		if (getprop("/it-autoflight/internal/elevator-cmd") >= 0.01 or getprop("/it-autoflight/internal/elevator-cmd") <= -0.01) {
			setprop("/it-autoflight/kap140/pt", "1");
		}
	} else if (status == 1) {
		setprop("/it-autoflight/kap140/pt", "0");
	}
}

var apLight = func {
	var apl = getprop("/it-autoflight/kap140/ap");
	if (apl >= 5) {
		apLightTimer.stop();
		setprop("/it-autoflight/kap140/ap", 0);
	} else {
		setprop("/it-autoflight/kap140/ap", apl + 1);
	}
}

##########
# Timers #
##########

var trimLightTimer = maketimer(0.5, trimLight);
var apLightTimer = maketimer(0.5, apLight);
