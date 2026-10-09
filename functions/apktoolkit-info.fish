function apktoolkit-info
    if test (count $argv) -lt 1
        echo "Uso: apktoolkit info <app.apk>"
        return 1
    end

    set apk $argv[1]

    if not test -f "$apk"
        echo "✗ APK no encontrado"
        return 1
    end

    echo
    echo "════════════════════════════════"
    echo " APK INFORMATION"
    echo "════════════════════════════════"
    echo

    echo "Archivo:"
    echo "  $apk"
    echo

    echo "Tamaño:"
    du -h "$apk" | cut -f1
    echo

    echo "Firma:"
    apksigner verify --print-certs "$apk"

    echo
    echo "APK/Manifest:"
    aapt2 dump badging "$apk" 2>/dev/null | head -n 20
end
