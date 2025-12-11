# Mobile Automation Framework 📱

Framework de automatización mobile usando **Appium + Ruby** con el patrón de diseño **Page Object Model (POM)** para aplicaciones Android e iOS.

## 📋 Tabla de Contenidos

- [Características](#características)
- [Arquitectura del Proyecto](#arquitectura-del-proyecto)
- [Prerequisitos](#prerequisitos)
- [Instalación](#instalación)
- [Configuración](#configuración)
- [Uso](#uso)
- [Ejecución de Tests](#ejecución-de-tests)
- [Estructura del Proyecto](#estructura-del-proyecto)
- [Documentación Adicional](#documentación-adicional)

## ✨ Características

- ✅ Soporte para **Android** e **iOS**
- ✅ Patrón de diseño **Page Object Model (POM)**
- ✅ Framework de testing **RSpec**
- ✅ Gestión centralizada del driver de Appium
- ✅ Helpers para gestos móviles (swipe, scroll, tap, etc.)
- ✅ Captura automática de screenshots en fallos
- ✅ Configuración flexible mediante variables de entorno
- ✅ Tareas automatizadas con **Rake**
- ✅ Ejemplos de tests listos para usar

## 🏗️ Arquitectura del Proyecto

Este framework sigue el patrón **Page Object Model (POM)**:

```
┌─────────────┐
│   Tests     │ ← RSpec test specs
└──────┬──────┘
       │
       ↓
┌─────────────┐
│ Page Objects│ ← Encapsulan elementos y acciones de UI
└──────┬──────┘
       │
       ↓
┌─────────────┐
│  Base Page  │ ← Métodos comunes reutilizables
└──────┬──────┘
       │
       ↓
┌─────────────┐
│   Driver    │ ← Gestión del driver de Appium
│  Manager    │
└─────────────┘
```

## 📦 Prerequisitos

Antes de instalar el framework, necesitas tener instalado:

### 1. **Ruby**
- Versión recomendada: **Ruby 3.0+**
- Verificar instalación: `ruby --version`
- Descargar desde: [https://www.ruby-lang.org/](https://www.ruby-lang.org/)

### 2. **Node.js y npm**
- Versión recomendada: **Node.js 16+**
- Verificar instalación: `node --version` y `npm --version`
- Descargar desde: [https://nodejs.org/](https://nodejs.org/)

### 3. **Bundler**
```bash
gem install bundler
```

### 4. **Appium**
Ver la guía completa de instalación en [docs/APPIUM_SETUP.md](docs/APPIUM_SETUP.md)

```bash
npm install -g appium
```

### 5. **Para Android:**
- **Android Studio** con SDK instalado
- **Java JDK 8+**
- Variables de entorno configuradas:
  - `ANDROID_HOME`
  - `JAVA_HOME`

### 6. **Para iOS (solo macOS):**
- **Xcode** (última versión)
- **Xcode Command Line Tools**
```bash
xcode-select --install
```

## 🚀 Instalación

### 1. Clonar el repositorio
```bash
git clone <tu-repositorio>
cd cambioseguro-automation-mobile
```

### 2. Instalar dependencias de Ruby
```bash
bundle install
```

O usando Rake:
```bash
rake setup
```

### 3. Configurar variables de entorno
```bash
cp .env.example .env
```

Edita el archivo `.env` con tus configuraciones:

```env
# Android
ANDROID_DEVICE_NAME=Android Emulator
ANDROID_PLATFORM_VERSION=13.0
ANDROID_APP_PATH=./apps/android/app-debug.apk
ANDROID_APP_PACKAGE=com.example.app
ANDROID_APP_ACTIVITY=.MainActivity

# iOS
IOS_DEVICE_NAME=iPhone 14
IOS_PLATFORM_VERSION=16.0
IOS_APP_PATH=./apps/ios/app.app
IOS_BUNDLE_ID=com.example.app
```

### 4. Verificar la instalación de Appium
```bash
rake check_appium
```

O directamente:
```bash
appium-doctor
```

## ⚙️ Configuración

### Archivos de Configuración

- **`config/appium_settings.rb`** - Configuración general de Appium
- **`config/android_caps.rb`** - Capabilities para Android
- **`config/ios_caps.rb`** - Capabilities para iOS
- **`.env`** - Variables de entorno (no commiteado)

### Configurar tu aplicación

1. Coloca tu APK en `apps/android/` o tu APP/IPA en `apps/ios/`
2. Actualiza los locators en los Page Objects según tu aplicación
3. Modifica el archivo `.env` con los datos de tu app

## 🎯 Uso

### Estructura de un Test

```ruby
# spec/android/mi_test_spec.rb
require 'spec_helper'
require_relative '../../lib/pages/android/login_page'

RSpec.describe 'Mi Test Suite', :android do
  let(:login_page) { AndroidLoginPage.new }

  it 'debería hacer algo' do
    # Arrange
    username = 'mi_usuario'
    
    # Act
    login_page.enter_username(username)
    
    # Assert
    expect(login_page.element_displayed?(:id, 'elemento_id')).to be true
  end
end
```

### Crear un Page Object

```ruby
# lib/pages/android/mi_page.rb
require_relative '../../base_page'

class MiPage < BasePage
  # Definir locators
  MI_ELEMENTO = { type: :id, value: 'com.app:id/elemento' }.freeze
  
  # Métodos de interacción
  def tap_elemento
    tap_element(MI_ELEMENTO[:type], MI_ELEMENTO[:value])
  end
  
  def elemento_visible?
    element_displayed?(MI_ELEMENTO[:type], MI_ELEMENTO[:value])
  end
end
```

## 🏃 Ejecución de Tests

### Ejecutar todos los tests de Android
```bash
rake android:test
```

### Ejecutar todos los tests de iOS
```bash
rake ios:test
```

### Ejecutar solo smoke tests
```bash
rake android:smoke
rake ios:smoke
```

### Ejecutar tests con RSpec directamente

**Android:**
```bash
PLATFORM=android rspec spec/android/
```

**iOS:**
```bash
PLATFORM=ios rspec spec/ios/
```

### Ejecutar un test específico
```bash
PLATFORM=android rspec spec/android/login_spec.rb
```

### Ejecutar con tags
```bash
PLATFORM=android rspec --tag smoke
```

### Limpiar reportes y screenshots
```bash
rake clean
```

## 📁 Estructura del Proyecto

```
cambioseguro-automation-mobile/
├── config/                      # Archivos de configuración
│   ├── appium_settings.rb      # Configuración general
│   ├── android_caps.rb         # Capabilities Android
│   └── ios_caps.rb             # Capabilities iOS
├── lib/                        # Código del framework
│   ├── base_page.rb           # Clase base para Page Objects
│   ├── driver_manager.rb      # Gestión del driver Appium
│   ├── helpers/               # Utilidades helper
│   │   ├── gestures_helper.rb # Gestos móviles
│   │   └── screenshot_helper.rb # Gestión de screenshots
│   └── pages/                 # Page Objects
│       ├── android/           # Pages específicos de Android
│       │   └── login_page.rb
│       └── ios/               # Pages específicos de iOS
│           └── login_page.rb
├── spec/                       # Tests
│   ├── spec_helper.rb         # Configuración de RSpec
│   ├── android/               # Tests de Android
│   │   └── login_spec.rb
│   └── ios/                   # Tests de iOS
│       └── login_spec.rb
├── apps/                       # Aplicaciones móviles
│   ├── android/               # APKs
│   └── ios/                   # IPAs/APPs
├── screenshots/                # Screenshots (auto-generado)
├── reports/                    # Reportes (auto-generado)
├── docs/                       # Documentación adicional
│   └── APPIUM_SETUP.md        # Guía de instalación de Appium
├── .env                        # Variables de entorno (no commitear)
├── .env.example               # Template de variables
├── .gitignore                 # Archivos ignorados por Git
├── Gemfile                     # Dependencias de Ruby
├── Rakefile                    # Tareas automatizadas
└── README.md                   # Este archivo
```

## 📚 Documentación Adicional

- **[Guía de Instalación de Appium](docs/APPIUM_SETUP.md)** - Instrucciones detalladas para instalar y configurar Appium
- **[Appium Documentation](https://appium.io/docs/)** - Documentación oficial de Appium
- **[RSpec Documentation](https://rspec.info/)** - Documentación oficial de RSpec

## 🔧 Métodos Disponibles en BasePage

### Interacción con Elementos
- `find_element(type, value)` - Encuentra un elemento
- `tap_element(type, value)` - Toca un elemento
- `send_keys_to_element(type, value, text)` - Envía texto a un elemento
- `get_text(type, value)` - Obtiene el texto de un elemento
- `element_displayed?(type, value)` - Verifica si está visible
- `element_enabled?(type, value)` - Verifica si está habilitado

### Waits
- `wait_for_element(type, value, timeout: 30)` - Espera a que aparezca
- `wait_for_element_not_present(type, value)` - Espera a que desaparezca
- `wait_for_element_clickable(type, value)` - Espera a que sea clickeable

### Gestos (GesturesHelper)
- `swipe_up()` / `swipe_down()` / `swipe_left()` / `swipe_right()`
- `scroll_to_element(type, value)`
- `scroll_to_text(text)`
- `long_press_element(type, value)`
- `double_tap_element(type, value)`

### Otros
- `go_back()` - Navega hacia atrás
- `hide_keyboard()` - Oculta el teclado
- `take_screenshot(filename)` - Captura screenshot
- `switch_to_webview()` / `switch_to_native()` - Cambio de contexto

## 🎨 Tipos de Locators Soportados

### Android
- `:id` - Resource ID (`com.app:id/button`)
- `:accessibility_id` - Accessibility ID
- `:xpath` - XPath
- `:class_name` - Class name
- `:uiautomator` - UiAutomator selector

### iOS
- `:accessibility_id` - Accessibility ID
- `:id` - ID
- `:xpath` - XPath
- `:class_name` - Class name
- `:predicate` - iOS Predicate String
- `:class_chain` - iOS Class Chain

## 🤝 Contribuciones

1. Crea un branch para tu feature (`git checkout -b feature/nueva-funcionalidad`)
2. Commit tus cambios (`git commit -am 'Agrega nueva funcionalidad'`)
3. Push al branch (`git push origin feature/nueva-funcionalidad`)
4. Crea un Pull Request

## 📝 Notas Importantes

- Los screenshots se guardan automáticamente cuando un test falla
- Los screenshots antiguos (>7 días) se eliminan automáticamente
- Puedes usar tags en RSpec (`:smoke`, `:regression`, etc.) para organizar tus tests
- El driver se inicia y cierra automáticamente antes/después de cada test

## 🐛 Solución de Problemas

### Error: "Could not start driver"
- Verifica que Appium esté corriendo: `appium`
- Verifica las capabilities en el archivo de configuración

### Error: "App not found"
- Verifica la ruta en `.env`
- Asegúrate de que el APK/APP exista en la ruta especificada

### Error: "No device connected"
- Android: Verifica con `adb devices`
- iOS: Verifica que el simulador esté abierto

Para más ayuda, consulta [docs/APPIUM_SETUP.md](docs/APPIUM_SETUP.md)

---

**Happy Testing! 🎉**
