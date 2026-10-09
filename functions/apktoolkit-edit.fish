
function apktoolkit-edit
    if test (count $argv) -lt 1
        echo "Uso: apktoolkit edit <ruta-del-archivo>"
        echo "Ejemplo: apktoolkit edit smali/com/example/Main.smali"
        return 1
    end

    set -l file (realpath "$argv[1]" 2>/dev/null)

    if test -z "$file"; or not test -f "$file"
        echo "✗ No existe el archivo: $argv[1]"
        return 1
    end

    set -l root (realpath .)
    set -l smali_root "$root/smali/"
    set -l java_root "$root/java/"

    if not string match -q "$smali_root*" -- "$file"; and \
       not string match -q "$java_root*" -- "$file"
        echo "✗ Por seguridad, solo puedes editar archivos dentro"
        echo "  de smali/ o java/ desde la raíz del proyecto."
        return 1
    end

    vim "$file"
end
