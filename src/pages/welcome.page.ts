export class WelcomePage {
    get continueButton() {
        return $('~Continuar');
    }

    get registerHereButton() {
        return $('~Regístrate aquí');
    }

    get personalProfileButton() {
        return $('~Personal\noperaciones a tu nombre');
    }

    async tapContinue() {
        await this.continueButton.waitForDisplayed({ timeout: 15000 });
        await this.continueButton.click();
    }

    async tapRegisterHere() {
        await this.registerHereButton.waitForDisplayed({ timeout: 15000 });
        await this.registerHereButton.click();
    }

    async tapPersonalProfile() {
        await this.personalProfileButton.waitForDisplayed({ timeout: 15000 });
        await this.personalProfileButton.click();
    }

    async isPersonalProfileVisible() {
        await this.personalProfileButton.waitForDisplayed({ timeout: 15000 });
        return true;
    }
}