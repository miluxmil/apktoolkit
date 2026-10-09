
#!/usr/bin/env fish

set -l source_dir (path dirname (status filename))
set -l functions_dir "$source_dir/functions"
set -l scripts_dir "$source_dir/scripts"
set -l target_dir ~/.config/fish/functions
set -l fixer "apktoolkit-fix-resources.py"

if not test -d "$functions_dir"
    echo "✗ No encuentro el directorio functions/"
    return 1
end

if not test -f "$scripts_dir/$fixer"
    echo "✗ No encuentro el corrector Python:"
    echo "  $scripts_dir/$fixer"
    return 1
end

mkdir -p "$target_dir"
or return 1

echo "→ Instalando funciones de APK Toolkit..."

for file in "$functions_dir"/apktoolkit*.fish
    if test -f "$file"
        cp "$file" "$target_dir/"
        or return 1
    end
end

echo "→ Instalando corrector de recursos..."

cp "$scripts_dir/$fixer" "$target_dir/$fixer"
or return 1

echo
echo "✓ Instalación completada."
echo "  Funciones: $target_dir"
echo "  Corrector: $target_dir/$fixer"
echo
echo "Recarga la función principal con:"
echo "source ~/.config/fish/functions/apktoolkit.fish"
echo
echo "Comprueba la ayuda con:"
echo "apktoolkit help"
