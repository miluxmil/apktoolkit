function apktoolkit-verify
    if test (count $argv) -lt 1
        echo "Uso: apktoolkit verify <app.apk>"
        return 1
    end

    set apk $argv[1]

    if not test -f "$apk"
        echo "✗ APK no encontrado"
        return 1
    end

    echo
    echo "APK Toolkit"
    echo "────────────────────────────────"
    echo "Archivo: $apk"
    echo

    echo "Firma:"
    apksigner verify --verbose "$apk"

    if test $status -eq 0
        echo "✓ Firma válida"
    else
        echo "✗ Firma inválida"
    end

    echo
    echo "Certificado:"
    apksigner verify --print-certs "$apk"

    echo
    echo "Alineación:"
    zipalign -c -v 4 "$apk"
end
