function apktoolkit-decode
    if test (count $argv) -lt 1
        echo "Uso: apktoolkit decode <app.apk>"
        return 1
    end

    set apk $argv[1]

    if not test -f "$apk"
        echo "✗ APK no encontrado: $apk"
        return 1
    end

    set name (basename "$apk" .apk)
    set output "$name-smali"

    echo "→ Apktool → $output"

    apktool d "$apk" -o "$output"

    if test $status -eq 0
        echo "✓ Decompilación completada"
    end
end
