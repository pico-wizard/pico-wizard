import importlib
import os
from inspect import isclass
from pathlib import Path

from pico.module import Module4

packageDir = Path(__file__).resolve().parent

for moduleName in os.listdir(packageDir):
    if os.path.isdir(os.path.join(packageDir, moduleName)):
        for file in os.listdir(os.path.join(packageDir, moduleName)):
            if file.endswith('.py'):
                file = file[:-3]

                try:
                    module = importlib.import_module(f"{__name__}.{moduleName}.{file}")

                    for clsName in dir(module):
                        cls = getattr(module, clsName)

                        if isclass(cls) and issubclass(cls, Module):
                            globals()[clsName] = cls
                except ModuleNotFoundError:
                    pass
