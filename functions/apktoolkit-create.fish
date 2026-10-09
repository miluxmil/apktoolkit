
function apktoolkit-create
    if test (count $argv) -lt 1
        echo "Uso: apktoolkit create <app.apk> [nombre-proyecto]"
        echo
        echo "Ejemplos:"
        echo "  apktoolkit create app.apk"
        echo "  apktoolkit create app.apk MiProyecto"
        return 1
    end

    set apk (realpath "$argv[1]" 2>/dev/null)

    if test -z "$apk"; or not test -f "$apk"
        echo "✗ No existe el archivo: $argv[1]"
        return 1
    end

    if not string match -q -r '\.apk$' -- "$apk"
        echo "✗ El archivo debe tener extensión .apk"
        return 1
    end

    # Detectar el nombre visible de la aplicación.
    set filename (basename "$apk" .apk)
    set app_label (aapt2 dump badging "$apk" 2>/dev/null \
        | string match -r "^application-label:'[^']*'" \
        | head -n 1 \
        | string replace -r '^application-label:\x27(.*)\x27$' '$1')

    # Permitir un nombre personalizado.
    if test (count $argv) -ge 2
        set project_name "$argv[2]"
        echo "→ Usando nombre personalizado."
    else if test -n "$app_label"
        set project_name "$app_label"
        echo "→ Nombre detectado: $app_label"
    else
        set project_name "$filename"
        echo "→ No se detectó el nombre; usando el del APK."
    end

    # Convertir el nombre en uno seguro para una carpeta.
    set project_name (string replace -ra '[^[:alnum:]_-]+' '_' -- "$project_name")
    set project_name (string trim -c '_' -- "$project_name")

    if test -z "$project_name"
        set project_name "$filename"
    end

    # Evitar sobrescribir proyectos existentes.
    set project "$project_name"
    set counter 2

    while test -e "$project"
        set project "$project_name"_"$counter"
        set counter (math $counter + 1)
    end

    echo
    echo "→ Creando proyecto: $project"

    mkdir -p "$project"/original \
             "$project"/java \
             "$project"/build \
             "$project"/logs

    if test $status -ne 0
        echo "✗ No se pudieron crear las carpetas."
        return 1
    end

    if not cp "$apk" "$project/original/"
        echo "✗ No se pudo copiar el APK original."
        rm -rf "$project"
        return 1
    end

    echo "→ Decodificando con Apktool..."

    apktool d "$apk" -o "$project/smali"

    if test $status -ne 0
        echo "✗ Error durante la decompilación."
        echo "→ Se conserva el APK original; revisa el proyecto:"
        echo "  $project/"
        return 1
    end

    echo
    echo "✓ Proyecto creado correctamente:"
    echo "  $project/"
    echo
    echo "  original/  → APK original"
    echo "  smali/     → Código Smali, recursos y manifiesto"
    echo "  java/      → Destino del código decompilado con JADX"
    echo "  build/     → APKs generados"
    echo "  logs/      → Registros"
    echo
    echo "Siguiente paso:"
    echo "  cd '$project'"
    echo "  apktoolkit java"
    echo "  apktoolkit build"
    echo
end
