import importlib
import sys

target = sys.argv[1]
if target == "":
    target_scope = globals()["__builtins__"]
else:
    target_scope = importlib.import_module(target)

for symbol in dir(target_scope):
    if symbol.startswith("_"):
        continue
    print(symbol)
