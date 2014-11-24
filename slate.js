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

var halfRight = S.operation("move", {
  "screen" : monMain,
  "x" : "screenSizeX/2",
  "y" : "0",
  "width" : "screenSizeX/2",
  "height" : "screenSizeY"
});

var hideChat = S.operation("hide", { "app" : "Terminal" });
var showChat = S.operation("show", {
  "app" : ["Terminal"]
});
var focusTerm = S.operation("focus", { "app" : "Terminal" });

var twoThirdsLeft = S.operation("move", {
  "screen" : monMain,
  "x" : "0",
  "y" : "0",
  "width" : "screenSizeX * 2 / 3",
  "height" : "screenSizeY"
});

// Layout
var HPSetupLayout = S.layout("HPSetupLayout", {
  "_before_" : { "operations" : showChat, "repeat-last" : true },
  "_after_" : { "operations" : focusTerm },
  "Terminal" : {
    "operations" : [bottomRight, topRight],
    "title-order-regex" : [".+⌘1$"],
    "repeat" : true
  },
  "Safari" : {
    "operations" : [mainLeft]
  }
});

var SingleSetupLayout = S.layout("SingleSetupLayout", {
  "Terminal" : {
    "operations" : [halfRight, hideChat],
    "title-order-regex" : [".+⌘1$"],
    "repeat" : true
  },
  "Safari" : {
    "operations" : [twoThirdsLeft]
  }
});

S.bind("space:ctrl", S.operation("layout", { "name" : HPSetupLayout }));
// S.bind("space:ctrl", S.operation("layout", { "name" : SingleSetupLayout }));
S.default([monHP,monMain], HPSetupLayout);
S.default([monMain], SingleSetupLayout);
