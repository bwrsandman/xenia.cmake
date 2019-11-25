#!/usr/bin/env python3

# xenia.cmake - xenia building in cmake
# Written in 2019 by Sandy Carter <bwrsandman@gmail.com>

# To the extent possible under law, the author(s) have dedicated all copyright
# and related and neighboring rights to this software to the public domain
# worldwide. This software is distributed without any warranty.

# You should have received a copy of the CC0 Public Domain Dedication along with
# this software. If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.

import os
import importlib

def main():
    # Workaround to import xenia-build as a python module
    path = os.path.join(os.path.dirname(os.path.realpath(__file__)),
                        "xenia/xenia-build")
    module_name = "xb"
    loader = importlib.machinery.SourceFileLoader(module_name, path)
    spec = importlib.util.spec_from_loader(module_name, loader)
    xb = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(xb)
    # Generate a build/version.h
    xb.generate_version_h()

if __name__ == '__main__':
    exit(main())
