import pkgutil

for p in pkgutil.walk_packages():
    if p.name.startswith("_"):
        continue
    print(p.name)
