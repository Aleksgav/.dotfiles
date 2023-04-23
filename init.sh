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

echo "Detecting OS..."
os_detect

echo "$os"

if [ "$os" = "UNKNOWN" ]; then
    echo "Unknown OS. Exit..."

    exit 1
fi

if [[ "$os" == "OSX" ]]; then
    echo "Install OSX additions"

    echo "Installing Homebrew..."
    /bin/bash -c "$(sudo curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"

    echo "Installing GPG..."
    brew install gpg

    echo "Installing RVM"
    echo "Installing GPG keys..."
    gpg --keyserver keyserver.ubuntu.com --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
    echo "Installing RVM..."
    \curl -sSL https://get.rvm.io | bash -s stable --ruby

    source ~/.rvm/scripts/rvm

    echo "Installing gems..."
    gem install pastel
    gem install tty-box
    gem install tty-screen
    gem install tty-spinner

    echo "Running main installation script..."
    ./init.rb
fi
