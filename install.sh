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
    # Required developer tools for Mac OS
    xcode-select --install
    # oh-my-zsh
    if [ ! -d "$/Users/${USER}/.oh-my-zsh"]; then
        echo "installing oh-my-zsh"
        #sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    fi
    
    # Install homebrew if it's not installed by checking that the symlink doesn't exist
    if [ ! -h /usr/local/bin/brew ]; then
        echo "Homebrew not found, installing..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"  
    fi
    brew update
    # Install powerline fonts
    git clone https://github.com/powerline/fonts && cd fonts && exec './install.sh'
    rm -rf fonts/
    # Tap to install Hashicorp tools 
    brew tap hashicorp/tap
    # Install Hashicorp tools
    brew install terraform \            # All the HashiCorp things
                 packer     \ 
                 nomad       \
                 vault        \
                 consul        \
                 waypoint       \
                 vagrant         \ 
                 boundary
    brew install --cask virtualbox          # Virtualbox, use as a provider for Vagrant

    # Clould CLIs
    brew install awscli
    brew install azure-cli
    brew install --cask google-cloud-sdk

    # Languages
    brew install --cask anaconda            # Python
    brew install node@14                    # Node LTS
    brew install typescript                 # Typescript
    brew install golang                     # Go
    brew install --cask dotnet              # C#
        brew install mono-libgdiplus            # Install if using System.Drawing.Common with C#
    brew install --cask corretto            # AWS OpenJDK

    # IACs
    npm i -g aws-cdk                        # AWS CDK. Installs cdkv1
    brew install pulumi                     # Pulumi
    brew install cloudformation-cli         # CloudFormation CLI. Note: You can use the awscli to interact with CloudFormation as well.
    brew install cfn-lint                   # cfn-lint for CloudFormation
    
    # Assorted tools
    brew install httpie                     # A prettier curl/wget
    brew install jq                         # command line json parser
    brew install tmux                       # Terminal Multiplexer
    brew install vim                        # Brew provided vim. The shipped version of vim with macos is missing features like folding.
    brew install --cask obsidian            # Markdown-focused personal knowledge base. Works well for folks doing zettelkasten
    brew install lftp                       # Nice CLI FTP
    brew install --cask typora              # A markdown editor with awesome UX

    # IDEs
    brew install --cask visual-studio-code  # Visual Studio Code
    ;;
esac

# Setting locales. I use UTF-8, but you can customize it here for your region if needed
export LANG="en_US.UTF-8"
export LC_TYPE="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"




