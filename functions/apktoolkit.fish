

function apktoolkit
    set -l show_help 0

    if test (count $argv) -eq 0
        set show_help 1
    else if contains -- $argv[1] help -h --help
        set show_help 1
    end

    if test $show_help -eq 1
	apktoolkit-help
    end

    switch $argv[1]
        case create
            apktoolkit-create $argv[2..-1]
        case decode
            apktoolkit-decode $argv[2..-1]
        case java
            apktoolkit-java $argv[2..-1]
        case build
            apktoolkit-build $argv[2..-1]
        case sign
            apktoolkit-sign $argv[2..-1]
        case verify
            apktoolkit-verify $argv[2..-1]
        case install
            apktoolkit-install $argv[2..-1]
        case uninstall
            apktoolkit-uninstall $argv[2..-1]
	case clean
            apktoolkit-clean $argv[2..-1]
	case search
            apktoolkit-search $argv[2..-1]
        case files
            apktoolkit-files $argv[2..-1]
        case edit
            apktoolkit-edit $argv[2..-1]
        case info
            apktoolkit-info $argv[2..-1]
        case log
            apktoolkit-log $argv[2..-1]
        case '*'
            echo "Error: comando desconocido: $argv[1]"
            echo "Consulta la ayuda con: apktoolkit help"
            return 1
    end
end
