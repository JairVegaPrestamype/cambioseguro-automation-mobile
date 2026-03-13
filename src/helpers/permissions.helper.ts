export async function allowPermissionsIfPresent() {

    const selectors = [
        'android=new UiSelector().text("Permitir")',
        'android=new UiSelector().text("Allow")',
        'android=new UiSelector().resourceId("com.android.permissioncontroller:id/permission_allow_button")',
        'android=new UiSelector().resourceId("com.android.permissioncontroller:id/permission_allow_foreground_only_button")'
    ];

    for (const selector of selectors) {

        const element = await $(selector);

        if (await element.isExisting() && await element.isDisplayed()) {
            await element.click();
            await driver.pause(1000);
            return true;
        }
    }

    return false;
}