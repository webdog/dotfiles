#!/usr/bin/env zsh

# Evaluating the name of the system Kernel to install specific environment tools and packages. Forgoing
# sudo as I work from root in my development containers.
case "$(uname -s)" in
    Linux)
        if [ "$(grep -Ei 'debian|buntu' /etc/*release)" ]; then
        echo "Debian Environment, Updating..."
        apt -y install build-essential debconf locales > /dev/null 2>&1
        apt -y install curl
        locale-gen --purge en_US.UTF-8 > /dev/null 2>&1
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.36.0/install.sh | zsh
        # Need to reload zshrc to get the NVM_DIR variables to install the latest node
        # Note: If you run this script manually, you'll need to run source again to
        # see nvm and node after the script has run.
        source '/root/.zshrc'
        nvm install node
        npm install -g aws-cdk
        echo "..."
        echo "done!"
        fi
    ;;
    Darwin)
    # TODO add my macOS configuration here
    echo "This is a macOS environment. Add your things here"
    ;;
esac

# Setting locales. I use UTF-8, but you can customize it here for your region if needed
export LANG="en_US.UTF-8"
export LC_TYPE="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"




