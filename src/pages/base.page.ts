export class BasePage {
    async waitVisible(selector: string, timeout = 15000) {
        const el = await $(selector);
        await el.waitForDisplayed({ timeout });
        return el;
    }

    async tap(selector: string) {
        const el = await this.waitVisible(selector);
        await el.click();
    }

    async getText(selector: string) {
        const el = await this.waitVisible(selector);
        return el.getText();
    }
}
