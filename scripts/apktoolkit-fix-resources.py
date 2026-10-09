from pathlib import Path
import re
import sys

root = Path(sys.argv[1])
res = root / "res"
drawable = res / "drawable"

if not drawable.is_dir():
    print("No se encontró res/drawable; no hay nada que corregir.")
    raise SystemExit(0)

mapping = {}

for path in drawable.iterdir():
    if path.is_file() and path.name.startswith("$"):
        new_name = path.name[1:]
        target = path.with_name(new_name)

        if target.exists():
            print(f"ERROR: conflicto de nombres: {target}")
            raise SystemExit(1)

        mapping[path.name] = new_name

if not mapping:
    print("✓ No se encontraron recursos incompatibles.")
    raise SystemExit(0)

pattern = re.compile(r'(?<![A-Za-z0-9_])\$([A-Za-z0-9_]+)')

changed = 0

for path in res.rglob("*.xml"):
    try:
        original = path.read_text(encoding="utf-8")
    except UnicodeDecodeError:
        continue

    updated = pattern.sub(r'\1', original)

    if updated != original:
        path.write_text(updated, encoding="utf-8")
        changed += 1

for old_name, new_name in mapping.items():
    (drawable / old_name).rename(drawable / new_name)

print(f"✓ Recursos renombrados: {len(mapping)}")
print(f"✓ XML actualizados: {changed}")
