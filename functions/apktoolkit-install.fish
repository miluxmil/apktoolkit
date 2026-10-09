function apktoolkit-install
    if test (count $argv) -lt 1
        echo "Uso: apktoolkit install <app.apk>"
        return 1
    end

    set apk $argv[1]

    if not test -f "$apk"
        echo "✗ APK no encontrado"
        return 1
    end

    echo "→ Instalando $apk..."

    adb install -r "$apk"
end
