import "dotenv/config";

export const androidCaps = {
    platformName: "Android",
    "appium:automationName": "UiAutomator2",

    // CLAVE: fuerza el device correcto
    "appium:udid": process.env.UDID || "AX3C026107001745",
    "appium:deviceName": process.env.DEVICE_NAME || "Honor-Android",

    "appium:autoGrantPermissions": true,
    "appium:noReset": false,
    "appium:newCommandTimeout": 120,
    "appium:appWaitDuration": 20000,

};
