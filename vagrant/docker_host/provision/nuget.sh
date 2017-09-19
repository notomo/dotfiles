#!/bin/sh
script_dir="$(cd "$(dirname "${BASH_SOURCE:-${(%):-%N}}")"; pwd)"
mono "${script_dir}/nuget.exe $*"
