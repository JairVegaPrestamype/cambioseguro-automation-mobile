export class RegisterPage {

    get howDidYouKnowButton() {
        return $('~¿Cómo conociste Cambio Seguro?\nSeleccionar');
    }

    get registerButton() {
        return $('~Registrarme');
    }

    async getFormFields() {
        return await $$('android.widget.EditText');
    }

    async fillPhone(phone: string) {
        const fields = await this.getFormFields();
        await fields[0].waitForDisplayed({ timeout: 15000 });
        await fields[0].setValue(phone);
    }

    async fillEmail(email: string) {
        const fields = await this.getFormFields();
        await fields[1].setValue(email);
    }

    async fillPassword(password: string) {
        const fields = await this.getFormFields();
        await fields[2].setValue(password);
    }

    async openHowDidYouKnow() {
        await this.howDidYouKnowButton.waitForDisplayed({ timeout: 10000 });
        await this.howDidYouKnowButton.click();
    }

    async selectRandomHowDidYouKnowOption() {
        await driver.pause(1000);

        const options = await $$('android.widget.Button');
        const validOptions = [];

        for (const option of options) {
            const displayed = await option.isDisplayed().catch(() => false);
            if (!displayed) continue;

            const desc = await option.getAttribute("contentDescription").catch(() => "");
            const value = (desc || "").trim();

            if (
                value &&
                value !== "Cerrar" &&
                value !== "Registrarme" &&
                value !== "Iniciar sesión"
            ) {
                validOptions.push(option);
            }
        }

        if (validOptions.length === 0) {
            throw new Error("No options found in '¿Cómo conociste Cambio Seguro?'");
        }

        const randomIndex = Math.floor(Math.random() * validOptions.length);
        const selectedText = await validOptions[randomIndex]
            .getAttribute("contentDescription")
            .catch(() => "unknown");

        console.log("Selected '¿Cómo conociste Cambio Seguro?':", selectedText);

        await validOptions[randomIndex].click();
    }

    async acceptTerms() {
        const views = await $$('android.view.View');

        for (const view of views) {
            const clickable = await view.getAttribute("clickable").catch(() => "false");
            const checked = await view.getAttribute("checked").catch(() => "false");
            const desc = await view.getAttribute("contentDescription").catch(() => "");

            if (
                clickable === "true" &&
                checked === "false" &&
                !desc?.includes("Registrarme") &&
                !desc?.includes("Ya tengo una cuenta")
            ) {
                await view.click();
                return;
            }
        }

        throw new Error("Terms checkbox was not found");
    }

    async tapRegister() {
        await this.registerButton.waitForDisplayed({ timeout: 10000 });
        await this.registerButton.click();
    }
}