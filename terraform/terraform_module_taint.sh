#!/usr/bin/env bash

function taint_module() {
    MODULE_NAME="$1"
    EXTRA_ARGS="${@:2}"

    for resource in "terraform show -module-depth=1 ${EXTRA_ARGS} | grep module.${MODULE_NAME} | tr -d ':' | sed -e 's/module.${MODULE_NAME}.//'"; do
        terraform taint -module ${MODULE_NAME} ${resource}
    done
}

function main() {
    taint_module $@
}

main $@
