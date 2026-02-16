import { BasePage } from "./base.page";

export class SettingsPage extends BasePage {

    // Más tolerante a idioma/versiones
    private settingsList = 'android=new UiSelector().resourceId("com.android.settings:id/recycler_view")';

    async isSettingsLoaded() {
        const el = await this.waitVisible(this.settingsList, 20000);
        return await el.isDisplayed();
    }
}
