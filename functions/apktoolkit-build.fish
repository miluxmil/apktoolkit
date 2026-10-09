function apktoolkit-build
    set -l source "smali"
    set -l build_dir "build"
    set -l tmp_dir "tmp"
    set -l work_dir "$tmp_dir/build-work"
    set -l unsigned "$tmp_dir/app-unsigned.apk"
    set -l aligned "$tmp_dir/app-aligned.apk"
    set -l signed "$build_dir/app-signed.apk"
    set -l keystore "$HOME/apk-tools/keystore/milux-release.jks"
    set -l fixer "$HOME/.config/fish/functions/apktoolkit-fix-resources.py"

    if not test -d "$source"
        echo "✗ No encuentro el directorio smali/"
        echo "  Ejecuta este comando desde un proyecto creado con apktoolkit."
        return 1
    end

    mkdir -p "$build_dir" "$tmp_dir"

    if test -d "$work_dir"
        rm -rf "$work_dir"
    end

    echo "[1/5] Preparando recursos..."

    cp -a "$source" "$work_dir"

    if not python "$fixer" "$work_dir"
        echo "✗ Falló la preparación de recursos"
        return 1
    end

    echo
    echo "[2/5] Compilando con Apktool..."

    if not apktool b "$work_dir" -o "$unsigned"
        echo "✗ Falló la compilación"
        return 1
    end

    echo
    echo "[3/5] Alineando APK..."

    if not zipalign -p 4 "$unsigned" "$aligned"
        echo "✗ Falló zipalign"
        return 1
    end

    echo
    echo "[4/5] Firmando APK..."

    if not test -f "$keystore"
        echo "✗ No encuentro el keystore:"
        echo "  $keystore"
        return 1
    end

    if not apksigner sign \
        --ks "$keystore" \
        --ks-key-alias milux \
        --out "$signed" \
        "$aligned"

        echo "✗ Falló la firma"
        return 1
    end

    echo
    echo "[5/5] Verificando..."

    if not apksigner verify --verbose "$signed"
        echo "✗ La firma no pudo verificarse"
        return 1
    end

    if not zipalign -c -v 4 "$signed"
        echo "✗ El APK no está correctamente alineado"
        return 1
    end

    echo
    echo "========================================"
    echo "✓ APK compilado correctamente"
    echo "========================================"
    echo
    echo "APK firmado:"
    echo "  $signed"
    echo
end
