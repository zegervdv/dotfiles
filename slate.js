S.cfga({
  "defaultToCurrentScreen" : true,
  "secondsBetweenRepeat" : 0.1,
  "checkDefaultsOnLoad" : true,
  "focusCheckWidthMax" : 3000,
  "orderScreensLeftToRight" : true,
  "keyboardLayout" : "azerty"
});

// Monitors
var monMain = "1280x800";
var monHP = "1920x1080";
var monMac = "2560x1400";

var extMonRef = "0";
var mainMonRef = "1";

var topRight = S.operation("move", {
  "screen" : extMonRef,
  "x" : "screenOriginX + 1140",
  "y" : "screenOriginY + 10",
  "width" : "760",
  "height" : "350",
});

var bottomRight = S.operation("move", {
  "screen" : extMonRef,
  "x" : "screenOriginX + 1140",
  "y" : "screenOriginY + 375",
  "width" : "760",
  "height" : "660",
});

var mainLeft = S.operation("move", {
  "screen" : extMonRef,
  "x" : "screenOriginX + 20",
  "y" : "screenOriginY + 10",
  "width" : "1080",
  "height" : "1020",
});

// Layout
var HPsetupLayout = S.layout("HPsetupLayout", {
  "Terminal" : {
    "operations" : [bottomRight, topRight],
    "repeat" : true
  },
  "Safari" : {
    "operations" : [mainLeft]
  }
});

S.bind("space:ctrl", S.operation("layout", { "name" : HPsetupLayout }));
S.default([monHP,monMain], HPsetupLayout);
