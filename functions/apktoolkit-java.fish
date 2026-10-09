function apktoolkit-java
    if test (count $argv) -ge 1
        set apk $argv[1]
    else
        if test -f "original/"*.apk
            set apk (find original -maxdepth 1 -type f -name '*.apk' | head -n 1)
        else if test -f "*.apk"
            set apk (find . -maxdepth 1 -type f -name '*.apk' | head -n 1)
        else
            echo "Uso: apktoolkit java <app.apk>"
            return 1
        end
    end

    if not test -f "$apk"
        echo "✗ APK no encontrado"
        return 1
    end

    if test -d "java"
        set output java
    else
        set name (basename "$apk" .apk)
        set output "$name-java"
    end

    mkdir -p "$output"

    echo "→ JADX → $output"

    jadx -d "$output" "$apk"

    if test $status -eq 0
        echo "✓ Decompilación Java completada"
    end
end
