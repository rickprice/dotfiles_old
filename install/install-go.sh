#!/bin/bash

mkdir -p $GOPATH/bin

binaries=(
    github.com/derekparker/delve/cmd/dlv
    github.com/kisielk/errcheck
    github.com/davidrjenni/reftools/cmd/fillstruct
    github.com/davidrjenni/reftools/cmd/fillswitch
    github.com/nsf/gocode
    github.com/jgautheron/goconst/cmd/goconst
    github.com/rogpeppe/godef
    github.com/godoctor/godoctor
    github.com/zmb3/gogetdoc
    github.com/motemen/go-iferr/cmd/goiferr
    github.com/ChimeraCoder/gojson/gojson # cat <path_to_yaml> | gojson -fmt=yaml -name=hello
    github.com/golangci/golangci-lint/cmd/golangci-lint
    golang.org/x/lint/golint
    github.com/fatih/gomodifytags
    github.com/securego/gosec/cmd/gosec
    github.com/jstemmer/gotags
    github.com/dnephin/govet
    golang.org/x/tools/cmd/guru
    github.com/gordonklaus/ineffassign
    mvdan.cc/interfacer
    mvdan.cc/unparam
    github.com/fatih/motion
    github.com/raviqqe/muffet
)


function install_go_binaries() {
    for item in "${binaries[@]}"; do
        filename=$(basename ${item})
        if [ ! -f $GOPATH/bin/$filename ]; then
            dot_mes_install ${filename}
            go get -u $item;
        fi
    done
}

function update_go_binaries() {
    for item in "${binaries[@]}"; do
        filename=$(basename ${item})
        dot_mes_update ${filename}
        go get -u $item;
    done
}
