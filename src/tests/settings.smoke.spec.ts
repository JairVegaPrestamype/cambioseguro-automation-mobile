import { expect } from "chai";
import { SettingsPage } from "../pages/settings.page";

describe("Settings Smoke Test", () => {
    let settingsPage: SettingsPage;

    before(() => {
        settingsPage = new SettingsPage();
    });

    it("should open Settings and show main list", async () => {
        // Fuerza abrir Settings de forma estable (sin mobile command)
        await driver.startActivity("com.android.settings", ".Settings");

        const pkg = await driver.getCurrentPackage();
        const activity = await driver.getCurrentActivity();

        console.log("PKG:", pkg);
        console.log("ACT:", activity);

        expect(pkg).to.equal("com.android.settings");

        const visible = await settingsPage.isSettingsLoaded();
        expect(visible).to.be.true;
    });
});
