
# APK Toolkit for Termux

Toolkit personal para analizar, modificar, compilar y firmar aplicaciones Android desde Termux utilizando Fish.

## Características

- Crear proyectos a partir de archivos APK.
- Decodificar recursos y código Smali con Apktool.
- Obtener código Java decompilado mediante JADX.
- Buscar texto en archivos Smali y Java.
- Listar archivos por tipo.
- Editar archivos del proyecto con Vim.
- Compilar, alinear y firmar APK.
- Verificar firmas y alineación.
- Instalar aplicaciones y consultar registros mediante ADB.
- Limpiar archivos temporales conocidos.
- Mostrar una ayuda integrada con colores.

## Requisitos

Este proyecto está diseñado para Termux y Fish.

Se necesitan las herramientas correspondientes a las funciones utilizadas:

- Fish
- Python 3
- ripgrep (`rg`)
- Vim
- Apktool
- JADX y su comando `jadx`
- Java
- AAPT2 (`aapt2`)
- Android SDK Build Tools: `apksigner` y `zipalign`
- ADB (`adb`) para las funciones relacionadas con dispositivos

Las herramientas deben estar disponibles en el `PATH`. La disponibilidad e instalación de cada paquete puede variar según el entorno de Termux.

## Instalación

Clona el repositorio:

```sh
git clone URL_DEL_REPOSITORIO
cd apktoolkit
```

Ejecuta el instalador con Fish:

```sh
fish install.fish
```

Carga la función principal:

```fish
source ~/.config/fish/functions/apktoolkit.fish
```

Consulta la ayuda:

```fish
apktoolkit help
```

## Uso

### Crear un proyecto

```fish
apktoolkit create app.apk
apktoolkit create app.apk MiProyecto
```

### Buscar código

```fish
apktoolkit search "onCreate"
apktoolkit search -s "invoke-virtual"
apktoolkit search -j "SharedPreferences"
apktoolkit search -i "password"
apktoolkit search -r 'on[A-Z].*'
```

- `-s`: buscar solo en Smali.
- `-j`: buscar solo en Java.
- `-i`: ignorar mayúsculas y minúsculas.
- `-r`: utilizar expresiones regulares.

### Listar archivos

```fish
apktoolkit files smali
apktoolkit files java
apktoolkit files xml
apktoolkit files all
```

### Editar código

```fish
apktoolkit edit smali/ruta/Clase.smali
```

### Compilar y firmar

Desde la raíz de un proyecto:

```fish
apktoolkit build
```

Consulta los comandos disponibles:

```fish
apktoolkit help
```

## Firma de APK

Las funciones de compilación y firma necesitan un keystore válido.

La configuración actual utiliza:

`~/apk-tools/keystore/milux-release.jks`

Debes conservar tu keystore y sus contraseñas en una copia de seguridad privada, fuera de este repositorio. Ajusta las rutas de las funciones si utilizas otra clave.

## Seguridad

- No subas archivos APK de terceros sin autorización.
- No publiques keystores, contraseñas, tokens ni claves privadas.
- Revisa los cambios antes de compilar o firmar.
- Conserva una copia del APK original.
- Comprueba las firmas de los APK antes de instalarlos.

## Limitaciones

Este proyecto está adaptado a un entorno Termux concreto. Algunas funciones dependen de herramientas externas, rutas locales, un dispositivo conectado o un keystore configurado.

La instalación de las funciones no instala automáticamente todas las dependencias.

## Licencia

Añade aquí una licencia antes de distribuir el proyecto públicamente.
