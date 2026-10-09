function apktoolkit-search
    set -l mode literal
    set -l insensitive 0
    set -l paths
    set -l query_parts
    set -l options_done 0

    for arg in $argv
        if test $options_done -eq 0
            switch "$arg"
                case --smali -s
                    set mode smali
                    continue
                case --java -j
                    set mode java
                    continue
                case --regex -r
                    set mode regex
                    continue
                case --ignore-case -i
                    set insensitive 1
                    continue
                case --
                    set options_done 1
                    continue
            end
        end

        set -a query_parts "$arg"
    end

    set -l query (string join ' ' $query_parts)

    if test -z "$query"
        echo "Uso: apktoolkit search [opciones] <texto>"
        echo
        echo "Opciones:"
        echo "  -s, --smali       Buscar solo en Smali"
        echo "  -j, --java        Buscar solo en Java"
        echo "  -r, --regex       Usar expresiones regulares"
        echo "  -i, --ignore-case Ignorar mayúsculas/minúsculas"
        echo
        echo "Ejemplos:"
        echo '  apktoolkit search "onCreate"'
        echo '  apktoolkit search -s "invoke-virtual"'
        echo '  apktoolkit search -j "SharedPreferences"'
        echo '  apktoolkit search -r "on[A-Z].*"'
        return 1
    end

    switch "$mode"
        case smali
            if test -d smali
                set paths smali
            end
        case java
            if test -d java
                set paths java
            end
        case literal regex
            for dir in smali java
                if test -d "$dir"
                    set -a paths "$dir"
                end
            end
    end

    if test (count $paths) -eq 0
        echo "✗ No encuentro los directorios necesarios."
        echo "  Ejecuta el comando desde la raíz del proyecto."
        return 1
    end

    echo "→ Buscando: $query"
    echo "  Modo: $mode"
    echo "  Directorios: "(string join ", " $paths)
    echo

    set -l rg_args --line-number --hidden
    set -a rg_args --glob '!*.apk' --glob '!*.class'

    if test $insensitive -eq 1
        set -a rg_args -i
    else
        set -a rg_args --smart-case
    end

    if test "$mode" = literal
        set -a rg_args --fixed-strings
    end

    set -a rg_args -- "$query"
    set -a rg_args $paths

    rg $rg_args
    set -l result $status

    if test $result -eq 1
        echo "No se encontraron coincidencias."
    else if test $result -ne 0
        echo "✗ La búsqueda terminó con un error."
        return $result
    end
end
