function apktoolkit-uninstall
    if test (count $argv) -lt 1
        echo "Uso: apktoolkit uninstall <package>"
        return 1
    end

    echo "→ Desinstalando $argv[1]..."

    adb uninstall "$argv[1]"
end
