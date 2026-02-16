import "dotenv/config";
import { androidCaps } from "./src/config/capabilities";

export const config: WebdriverIO.Config = {
    runner: "local",

    specs: ["./src/tests/**/*.spec.ts"],
    maxInstances: 1,

    capabilities: [androidCaps as any],

    logLevel: "info",
    waitforTimeout: 15000,

    framework: "mocha",
    mochaOpts: {
        ui: "bdd",
        timeout: 10 * 60 * 1000,
    },

    reporters: ["spec"],

    services: [
        [
            "appium",
            {
                args: {
                    address: "127.0.0.1",
                    port: 4723,
                },
            },
        ],
    ],

    afterTest: async function (_test, _context, { passed }) {
        if (!passed) {
            await driver.saveScreenshot(`./screenshots/${Date.now()}-fail.png`);
        }
    },
};