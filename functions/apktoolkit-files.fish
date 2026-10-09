function apktoolkit-files
    set -l type all
    set -l results

    if test (count $argv) -ge 1
        set type "$argv[1]"
    end

    switch "$type"
        case smali
            if test -d smali
                set results (find smali -type f -name '*.smali' 2>/dev/null)
            end

        case java
            if test -d java
                set results (find java -type f -name '*.java' 2>/dev/null)
            end

        case xml
            set results (find . -type f -name '*.xml' \
                -not -path './.git/*' \
                -not -path './build/*' \
                -not -path './tmp/*' \
                -not -path './original/*' \
                -not -path './logs/*' 2>/dev/null)

        case all
            set results (find . -type f \
                -not -name '*.apk' \
                -not -path './.git/*' \
                -not -path './build/*' \
                -not -path './tmp/*' \
                -not -path './original/*' \
                -not -path './logs/*' 2>/dev/null)

        case '*'
            echo "Uso: apktoolkit files [smali|java|xml|all]"
            return 1
    end

    if test (count $results) -eq 0
        echo "No se encontraron archivos del tipo: $type"
        echo "Comprueba que estás en la raíz del proyecto."
        return 0
    end

    echo "→ Archivos encontrados: "(count $results)
    printf '%s\n' $results
end
