import { expect } from "chai";
import { WelcomePage } from "../pages/welcome.page";
import { allowPermissionsIfPresent } from "../helpers/permissions.helper";
import { RegisterPage } from "../pages/register.page";
import { generateTestEmail } from "../helpers/email.helper";

describe("Register Personal Entry Test", () => {
    const APP_PACKAGE = "com.cambioseguro.test";
    const welcomePage = new WelcomePage();
    const registerPage = new RegisterPage();

    it("should navigate to personal registration entry", async () => {
        const email = generateTestEmail();

        await driver.activateApp(APP_PACKAGE);
        await driver.pause(4000);

        await allowPermissionsIfPresent();
        await driver.pause(2000);

        await welcomePage.tapContinue();
        await driver.pause(2000);

        await welcomePage.tapRegisterHere();
        await driver.pause(2000);

        await welcomePage.tapPersonalProfile();
        await driver.pause(2000);

        await registerPage.fillPhone("987654321");
        await registerPage.fillEmail(email);
        await registerPage.fillPassword("Pass1234!");

        await registerPage.openHowDidYouKnow();
        await registerPage.selectRandomHowDidYouKnowOption();
        await driver.pause(1000);

        await registerPage.acceptTerms();
        await driver.pause(1000);

        await registerPage.tapRegister();
        await driver.pause(3000);

        const currentPackage = await driver.execute("mobile: getCurrentPackage");
        expect(currentPackage).to.equal(APP_PACKAGE);
    });
});