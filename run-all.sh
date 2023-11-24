#!/bin/bash


SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

for dir in `find . -maxdepth 1 -type d -not -name '.*'`; do
  echo "Run example ${dir}..."
  cd "${SCRIPT_DIR}/${dir}" && zig build run
done
