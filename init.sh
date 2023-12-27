#!/bin/bash
set -e

os="UNKNOWN"
function os_detect {
    case "$OSTYPE" in
        solaris*) os="SOLARIS" ;;
        darwin*)  os="OSX" ;;
        linux*)   os="LINUX" ;;
        bsd*)     os="BSD" ;;
        msys*)    os="WINDOWS" ;;
        cygwin*)  os="WINDOWS" ;;
        *)        os="UNKNOWN" ;;
    esac
}

distro="UNKNOWN"
function linux_distibution_detect {
    . /etc/os-release

    case "$ID" in
        manjaro*) distro="MANJARO" ;;
        *)        distro="UNKNOWN" ;;
    esac
}

echo "Detecting OS..."
os_detect

echo "$os"

if [ "$os" = "UNKNOWN" ]; then
    echo "Unknown OS. Exit..."

    exit 1
fi

if [[ "$os" == "OSX" ]]; then
    . init_osx.sh

    exit 0
fi

if [[ "$os" == "LINUX" ]]; then
    echo "Detecting distro ..."

    . /etc/os-release

    case "$ID" in
        manjaro*) . init_linux_manjaro.sh ;;
        *)
            echo "Unknown distro. Exit..."
            ;;
    esac

    exit 0
fi
