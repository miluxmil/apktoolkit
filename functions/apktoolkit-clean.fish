
function apktoolkit-clean
    echo
    echo "APKTOOLKIT — Limpieza segura"
    echo "================================"

    # Comprobar que estamos en la raíz de un proyecto.
    if not test -d smali; or not test -d original
        echo "✗ No parece ser la raíz de un proyecto APK."
        echo "  Entra en la carpeta del proyecto e inténtalo de nuevo."
        return 1
    end

    # No seguir una carpeta temporal que sea un enlace simbólico.
    if test -L tmp
        echo "✗ La carpeta tmp es un enlace simbólico."
        echo "  Por seguridad, no se eliminará nada."
        return 1
    end

    if not test -d tmp
        echo "✓ No hay archivos temporales que limpiar."
        return 0
    end

    # Solo borrar temporales conocidos del toolkit.
    set -l targets \
        tmp/build-work \
        tmp/app-unsigned.apk \
        tmp/app-aligned.apk \
        tmp/apk-smali-test \
        tmp/app-test-unsigned.apk

    set -l removed 0

    for target in $targets
        if test -e "$target"; or test -L "$target"
            echo "→ Eliminando: $target"

            rm -rf -- "$target"

            if test $status -ne 0
                echo "✗ No se pudo eliminar: $target"
                return 1
            end

            set removed (math $removed + 1)
        end
    end

    echo
    if test $removed -eq 0
        echo "✓ No se encontraron temporales conocidos."
    else
        echo "✓ Limpieza completada. Elementos eliminados: $removed"
    end

    echo "✓ smali/, java/, original/, build/ y logs/ se conservaron."
    echo
end
