import fs from "fs";
import path from "path";

const COUNTER_FILE = path.resolve("./tmp/email-counter.json");

function padNumber(value: number, size: number): string {
    return value.toString().padStart(size, "0");
}

export function generateTestEmail(): string {
    let counter = 1;

    if (fs.existsSync(COUNTER_FILE)) {
        const raw = fs.readFileSync(COUNTER_FILE, "utf-8");
        const data = JSON.parse(raw);
        counter = Number(data.counter || 1);
    }

    const email = `cs-test-auto-${padNumber(counter, 4)}@cambioseguro.com`;

    fs.mkdirSync(path.dirname(COUNTER_FILE), { recursive: true });
    fs.writeFileSync(
        COUNTER_FILE,
        JSON.stringify({ counter: counter + 1 }, null, 2),
        "utf-8"
    );

    return email;
}