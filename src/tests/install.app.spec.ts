import { expect } from "chai";
import path from "path";

import { allowPermissionsIfPresent } from "../helpers/permissions.helper";

describe("App Installation Test", () => {
    const APP_PACKAGE = "com.cambioseguro.test";

    it("should uninstall and install the APK", async () => {
        const appPath = path.resolve("./apps/cambioseguro.apk");

        const installedBefore = await driver.isAppInstalled(APP_PACKAGE);
        console.log("Installed before:", installedBefore);

        if (installedBefore) {
            await driver.removeApp(APP_PACKAGE);
        }

        const installedAfterRemove = await driver.isAppInstalled(APP_PACKAGE);
        console.log("Installed after remove:", installedAfterRemove);
        expect(installedAfterRemove).to.equal(false);

        await driver.installApp(appPath);
        await driver.pause(3000);

        const installedAfterInstall = await driver.isAppInstalled(APP_PACKAGE);
        console.log("Installed after install:", installedAfterInstall);
        expect(installedAfterInstall).to.equal(true);

        await driver.activateApp(APP_PACKAGE);
        await driver.pause(5000);

        await allowPermissionsIfPresent();
        await driver.pause(2000);

        const currentPackage = await driver.execute("mobile: getCurrentPackage");
        console.log("Current package after open:", currentPackage);

        expect(currentPackage).to.equal(APP_PACKAGE);
    });
});