#!/bin/sh
script_dir="$(cd "$(dirname "${BASH_SOURCE:-${(%):-%N}}")"; pwd)"
mono --runtime=v4.0 ${script_dir}/nuget.exe $*
