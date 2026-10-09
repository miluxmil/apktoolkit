
function apktoolkit-help
    set -l c (set_color --bold cyan)
    set -l g (set_color green)
    set -l y (set_color yellow)
    set -l m (set_color magenta)
    set -l b (set_color --bold blue)
    set -l r (set_color red)
    set -l w (set_color --bold white)
    set -l n (set_color normal)

    echo
    echo "$c╭──────────────────────────────────────────────────────╮$n"
    echo "$c│$w             APK TOOLKIT  $y⚙$w  GUÍA DE USO$c              │$n"
    echo "$c╰──────────────────────────────────────────────────────╯$n"
    echo
    echo "$b━━━ INICIO Y PROYECTOS ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━$n"
    echo
    echo "  $g apktoolkit create$n <apk> [nombre]"
    echo "    Crea un proyecto desde un APK y prepara sus archivos."
    echo "    $y Ejemplo:$n apktoolkit create app.apk MiProyecto"
    echo
    echo "  $g apktoolkit decode$n"
    echo "    Decodifica el APK usando la configuración existente."
    echo
    echo "  $g apktoolkit java$n"
    echo "    Obtiene o consulta el código Java decompilado."
    echo
    echo "$b━━━ COMPILACIÓN Y FIRMA ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━$n"
    echo
    echo "  $g apktoolkit build$n"
    echo "    Compila el proyecto y prepara el APK firmado."
    echo
    echo "  $g apktoolkit sign$n"
    echo "    Firma un APK."
    echo
    echo "  $g apktoolkit verify$n"
    echo "    Verifica la firma del APK."
    echo
    echo "$b━━━ DISPOSITIVO Y DIAGNÓSTICO ━━━━━━━━━━━━━━━━━━━━━━━━$n"
    echo
    echo "  $g apktoolkit install$n"
    echo "    Instala el APK en un dispositivo conectado."
    echo
    echo "  $g apktoolkit uninstall$n"
    echo "    Desinstala la aplicación según la configuración existente."
    echo
    echo "  $g apktoolkit info$n"
    echo "    Muestra información del APK o proyecto."
    echo
    echo "  $g apktoolkit log$n"
    echo "    Consulta los registros disponibles."
    echo
    echo "$b━━━ BÚSQUEDA Y EDICIÓN ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━$n"
    echo
    echo "  $g apktoolkit search$n <opciones> <texto>"
    echo "    Busca texto dentro del código Smali y Java."
    echo "    $y Ejemplos:$n"
    echo "      apktoolkit search \"onCreate\""
    echo "      apktoolkit search -s \"invoke-virtual\""
    echo "      apktoolkit search -j \"SharedPreferences\""
    echo "      apktoolkit search -i \"password\""
    echo "      apktoolkit search -r 'on[A-Z].*'"
    echo
    echo "    $m Opciones de búsqueda:$n"
    echo "      -s, --smali        Solo archivos Smali"
    echo "      -j, --java         Solo archivos Java"
    echo "      -i, --ignore-case  Ignora mayúsculas/minúsculas"
    echo "      -r, --regex        Usa expresiones regulares"
    echo
    echo "  $g apktoolkit files$n [smali|java|xml|all]"
    echo "    Lista archivos por tipo."
    echo "    $y Ejemplos:$n"
    echo "      apktoolkit files smali"
    echo "      apktoolkit files xml"
    echo "      apktoolkit files java"
    echo
    echo "  $g apktoolkit edit$n <archivo>"
    echo "    Abre un archivo del proyecto en Vim."
    echo "    $y Ejemplo:$n"
    echo "      apktoolkit edit smali/ruta/Clase.smali"
    echo
    echo "$b━━━ MANTENIMIENTO ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━$n"
    echo
    echo "  $g apktoolkit clean$n"
    echo "    Limpia archivos temporales conocidos del proyecto."
    echo "    Conserva el código fuente y los APK de salida."
    echo
    echo "  $g apktoolkit help$n"
    echo "    Muestra esta guía."
    echo
    echo "$r⚠ IMPORTANTE$n"
    echo "  Trabaja desde la raíz del proyecto cuando corresponda."
    echo "  Conserva una copia del APK original antes de modificarlo."
    echo
    echo "$c━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━$n"
    echo "  $w Flujo habitual:$n"
    echo "  $y create$n → $y search/files$n → $y edit$n → $y build$n"
    echo
    echo "$c━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━$n"
    echo
end
