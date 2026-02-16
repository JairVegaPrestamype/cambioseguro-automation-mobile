import "dotenv/config";

export const androidCaps = {
    platformName: "Android",
    "appium:automationName": "UiAutomator2",

    // CLAVE: fuerza el device correcto
    "appium:udid": process.env.UDID || "emulator-5554",
    "appium:deviceName": process.env.DEVICE_NAME || "emulator-5554",

    "appium:autoGrantPermissions": true,
    "appium:noReset": true,
    "appium:newCommandTimeout": 120,

    "appium:appPackage": "com.android.settings",
    "appium:appActivity": ".Settings",

    "appium:appWaitPackage": "com.android.settings",
    "appium:appWaitActivity": "*",
    "appium:appWaitDuration": 20000,

};
