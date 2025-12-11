# Guía de Instalación y Configuración de Appium 📱

Esta guía te ayudará a instalar y configurar Appium en tu sistema para automatización de aplicaciones móviles Android e iOS.

## 📋 Tabla de Contenidos

- [¿Qué es Appium?](#qué-es-appium)
- [Prerequisitos](#prerequisitos)
- [Instalación de Appium](#instalación-de-appium)
- [Configuración para Android](#configuración-para-android)
- [Configuración para iOS](#configuración-para-ios-solo-macos)
- [Verificación de la Instalación](#verificación-de-la-instalación)
- [Instalación de Drivers](#instalación-de-drivers)
- [Iniciar Appium Server](#iniciar-appium-server)
- [Troubleshooting](#troubleshooting)

## ¿Qué es Appium?

Appium es un **servidor de automatización** de código abierto que permite automatizar aplicaciones móviles nativas, híbridas y web en plataformas iOS, Android y Windows.

### Características principales:
- ✅ Cross-platform (Android, iOS, Windows)
- ✅ Soporte para múltiples lenguajes de programación
- ✅ No requiere modificar el código de la aplicación
- ✅ Usa WebDriver protocol estándar

## 📦 Prerequisitos

### Todos los Sistemas

#### 1. **Node.js y npm**

Appium está construido sobre Node.js, por lo que necesitas tenerlo instalado.

**Windows:**
```powershell
# Descargar desde: https://nodejs.org/
# Verifica la instalación
node --version
npm --version
```

**macOS:**
```bash
# Usando Homebrew
brew install node

# Verifica la instalación
node --version
npm --version
```

**Versión recomendada:** Node.js 16.x o superior

#### 2. **Java JDK**

El Android SDK requiere Java.

**Windows:**
1. Descargar desde: https://www.oracle.com/java/technologies/downloads/
2. Instalar y configurar `JAVA_HOME`

**macOS:**
```bash
# Usando Homebrew
brew install openjdk@11

# Configurar JAVA_HOME en ~/.zshrc o ~/.bash_profile
export JAVA_HOME=$(/usr/libexec/java_home -v 11)
```

Verifica la instalación:
```bash
java -version
```

## 🚀 Instalación de Appium

### Instalación Global

El método recomendado es instalar Appium globalmente usando npm:

```bash
npm install -g appium
```

Verifica la instalación:
```bash
appium --version
```

### Instalación de Appium 2.x (Última versión)

```bash
# Instalar Appium 2
npm install -g appium@next

# Verificar versión
appium --version
```

## 🤖 Configuración para Android

### 1. Instalar Android Studio

**Descargar desde:** https://developer.android.com/studio

Durante la instalación, asegúrate de instalar:
- ✅ Android SDK
- ✅ Android SDK Platform
- ✅ Android Virtual Device (AVD)

### 2. Configurar Variables de Entorno

**Windows:**

1. Abrir "Variables de entorno del sistema"
2. Agregar las siguientes variables:

```powershell
# ANDROID_HOME
Variable: ANDROID_HOME
Valor: C:\Users\TU_USUARIO\AppData\Local\Android\Sdk

# JAVA_HOME
Variable: JAVA_HOME
Valor: C:\Program Files\Java\jdk-XX.X.X

# Agregar a PATH:
%ANDROID_HOME%\platform-tools
%ANDROID_HOME%\tools
%ANDROID_HOME%\tools\bin
%JAVA_HOME%\bin
```

Verifica en PowerShell:
```powershell
$env:ANDROID_HOME
$env:JAVA_HOME
adb --version
```

**macOS/Linux:**

Edita `~/.zshrc` o `~/.bash_profile`:

```bash
# Android SDK
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin

# Java
export JAVA_HOME=$(/usr/libexec/java_home -v 11)
export PATH=$PATH:$JAVA_HOME/bin
```

Recarga la configuración:
```bash
source ~/.zshrc  # o source ~/.bash_profile
```

Verifica:
```bash
echo $ANDROID_HOME
echo $JAVA_HOME
adb --version
```

### 3. Instalar Android SDK Platform Tools

Desde Android Studio:
1. Abre **Android Studio**
2. Ve a **Tools > SDK Manager**
3. En la pestaña **SDK Platforms**, instala la versión de Android que necesites (ej: Android 13.0)
4. En la pestaña **SDK Tools**, asegúrate de tener instalado:
   - ✅ Android SDK Build-Tools
   - ✅ Android SDK Platform-Tools
   - ✅ Android SDK Tools
   - ✅ Android Emulator
   - ✅ Intel x86 Emulator Accelerator (HAXM installer) - Windows
   - ✅ Google Play services

### 4. Configurar un Emulador (AVD)

```bash
# Listar emuladores disponibles
emulator -list-avds

# Si no tienes ninguno, créalo desde Android Studio:
# Tools > AVD Manager > Create Virtual Device
```

Inicia un emulador:
```bash
emulator -avd NOMBRE_DEL_AVD
```

### 5. Instalar UiAutomator2 Driver para Appium

```bash
appium driver install uiautomator2
```

Verifica:
```bash
appium driver list
```

## 🍎 Configuración para iOS (solo macOS)

### 1. Instalar Xcode

Descarga e instala **Xcode** desde la App Store.

Instala las Command Line Tools:
```bash
xcode-select --install
```

### 2. Instalar Xcode Command Line Tools

Verifica la instalación:
```bash
xcode-select -p
```

Debería mostrar: `/Applications/Xcode.app/Contents/Developer`

### 3. Instalar Homebrew (si no lo tienes)

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### 4. Instalar dependencias para iOS

```bash
# Instalar Carthage
brew install carthage

# Instalar libimobiledevice (para dispositivos reales)
brew install libimobiledevice

# Instalar ios-deploy (para dispositivos reales)
npm install -g ios-deploy

# Instalar ideviceinstaller
brew install ideviceinstaller
```

### 5. Instalar XCUITest Driver para Appium

```bash
appium driver install xcuitest
```

### 6. Configurar Simuladores iOS

Listar simuladores disponibles:
```bash
xcrun simctl list devices
```

Iniciar un simulador:
```bash
open -a Simulator
```

## ✅ Verificación de la Instalación

### Instalar Appium Doctor

Appium Doctor es una herramienta que verifica que tu sistema esté configurado correctamente:

```bash
npm install -g appium-doctor
```

### Verificar configuración de Android

```bash
appium-doctor --android
```

Deberías ver algo como:
```
✔ ANDROID_HOME is set to: /path/to/android/sdk
✔ JAVA_HOME is set to: /path/to/java
✔ adb exists at: /path/to/adb
✔ android exists at: /path/to/android
✔ emulator exists at: /path/to/emulator
```

### Verificar configuración de iOS (macOS)

```bash
appium-doctor --ios
```

Deberías ver:
```
✔ Xcode is installed at: /Applications/Xcode.app
✔ Xcode Command Line Tools are installed
✔ Carthage is installed
✔ ios-deploy is installed
```

## 🔌 Instalación de Drivers

Appium 2.x requiere que instales drivers explícitamente:

### UiAutomator2 (Android)
```bash
appium driver install uiautomator2
```

### XCUITest (iOS)
```bash
appium driver install xcuitest
```

### Verificar drivers instalados
```bash
appium driver list
```

Deberías ver:
```
✔ uiautomator2@X.X.X [installed (npm)]
✔ xcuitest@X.X.X [installed (npm)]
```

## 🚀 Iniciar Appium Server

### Inicio básico

```bash
appium
```

El servidor se inicia por defecto en: **http://127.0.0.1:4723**

### Inicio con configuración personalizada

```bash
# Especificar puerto
appium --port 4724

# Especificar dirección
appium --address 0.0.0.0

# Con logs detallados
appium --log-level debug

# Guardar logs en archivo
appium --log appium.log
```

### Verificar que Appium esté corriendo

En otra terminal:
```bash
curl http://127.0.0.1:4723/status
```

Deberías recibir una respuesta JSON.

## 🐛 Troubleshooting

### Problema 1: "appium: command not found"

**Solución:**
```bash
# Verificar instalación global de npm
npm list -g --depth=0

# Reinstalar Appium
npm install -g appium
```

### Problema 2: "ANDROID_HOME not set"

**Windows:**
1. Ve a Variables de entorno del sistema
2. Crea `ANDROID_HOME` apuntando a tu Android SDK (ej: `C:\Users\TU_USUARIO\AppData\Local\Android\Sdk`)

**macOS/Linux:**
```bash
# Editar ~/.zshrc o ~/.bash_profile
export ANDROID_HOME=$HOME/Library/Android/sdk
source ~/.zshrc
```

### Problema 3: "adb: command not found"

**Solución:**
```bash
# Agregar platform-tools a PATH
# Windows: Agregar %ANDROID_HOME%\platform-tools a PATH
# macOS/Linux:
export PATH=$PATH:$ANDROID_HOME/platform-tools
```

### Problema 4: "Could not find driver"

**Solución:**
```bash
# Instalar el driver necesario
appium driver install uiautomator2
appium driver install xcuitest

# Verificar
appium driver list
```

### Problema 5: Error al conectar con el emulador

**Solución:**
```bash
# Verificar dispositivos conectados
adb devices

# Si no aparece, reiniciar adb
adb kill-server
adb start-server

# Verificar nuevamente
adb devices
```

### Problema 6: "JAVA_HOME not set" en macOS

**Solución:**
```bash
# Encontrar instalación de Java
/usr/libexec/java_home

# Agregar a ~/.zshrc
export JAVA_HOME=$(/usr/libexec/java_home -v 11)
source ~/.zshrc
```

### Problema 7: Permisos en macOS

Si obtienes errores de permisos:
```bash
sudo chown -R $(whoami) $(npm config get prefix)/{lib/node_modules,bin,share}
```

## 📚 Comandos Útiles

### ADB (Android Debug Bridge)

```bash
# Listar dispositivos conectados
adb devices

# Instalar APK
adb install /path/to/app.apk

# Desinstalar app
adb uninstall com.package.name

# Ver logs
adb logcat

# Hacer screenshot
adb shell screencap /sdcard/screenshot.png
adb pull /sdcard/screenshot.png

# Iniciar activity
adb shell am start -n com.package.name/.ActivityName
```

### Emulador Android

```bash
# Listar emuladores
emulator -list-avds

# Iniciar emulador
emulator -avd NOMBRE_AVD

# Iniciar emulador borrado (cold boot)
emulator -avd NOMBRE_AVD -no-snapshot-load
```

### Simulador iOS

```bash
# Listar simuladores
xcrun simctl list devices

# Abrir simulador
open -a Simulator

# Boot un simulador específico
xcrun simctl boot "iPhone 14"

# Instalar app
xcrun simctl install booted /path/to/app.app

# Desinstalar app
xcrun simctl uninstall booted com.bundle.id
```

## 🔗 Recursos Adicionales

- **Documentación oficial de Appium:** https://appium.io/docs/
- **Appium GitHub:** https://github.com/appium/appium
- **Appium Pro:** https://appiumpro.com/
- **Android Developer:** https://developer.android.com/
- **iOS Developer:** https://developer.apple.com/xcode/

## ✅ Checklist de Instalación

- [ ] Node.js y npm instalados
- [ ] Java JDK instalado
- [ ] Appium instalado globalmente
- [ ] Android Studio instalado (para Android)
- [ ] Variables ANDROID_HOME y JAVA_HOME configuradas
- [ ] ADB funcionando (`adb devices`)
- [ ] Driver UiAutomator2 instalado
- [ ] Xcode instalado (para iOS en macOS)
- [ ] Driver XCUITest instalado (para iOS)
- [ ] `appium-doctor --android` sin errores
- [ ] `appium-doctor --ios` sin errores (macOS)
- [ ] Appium server inicia correctamente

---

**¡Listo! Ahora estás preparado para automatizar aplicaciones móviles con Appium. 🎉**
