function apktoolkit-sign
    if test (count $argv) -lt 1
        echo "Uso: apktoolkit sign <app.apk>"
        return 1
    end

    set input $argv[1]

    if not test -f "$input"
        echo "✗ APK no encontrado"
        return 1
    end

    set name (basename "$input" .apk)
    set output "$name-signed.apk"

    echo "→ Firmando..."

    apksigner sign \
                --ks ~/apk-tools/keystore/milux-release.jks \
                --ks-key-alias milux \
                --out "$output" \
                "$input"

    if test $status -ne 0
        echo "✗ Error al firmar"
        return 1
    end

    echo "→ Verificando..."

    apksigner verify --verbose "$output"

    echo
    echo "✓ APK firmado:"
    echo "  $output"
end
