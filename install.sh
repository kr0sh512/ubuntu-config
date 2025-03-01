#!/bin/bash

# Check if the script is run as root
if [ "$EUID" -ne 0 ]; then
    exec sudo "$0" "$@"
    exit 1
fi

# Update the package list
sudo apt update

# Print a message in red color
RED_COLOR="\e[31m"
BLUE_COLOR="\e[34m"
GREEN_COLOR="\e[32m"
YELLOW_COLOR="\e[33m"
PURPLE_COLOR="\e[35m"
CYAN_COLOR="\e[36m"
WHITE_COLOR="\e[37m"
NO_COLOR="\e[0m"

# Upgrade all installed packages to their latest versions
sudo apt upgrade -y

# Remove unnecessary packages and dependencies
sudo apt autoremove -y

# Clean up the local repository of retrieved package files
sudo apt clean

echo -e "${GREEN_COLOR}The system has been updated successfully.${NO_COLOR}"
echo -e "${CYAN_COLOR}Console section${NO_COLOR}"

# Ask for permission to install git
read -p "Do you want to install Git? (Y/n): " install_git
install_git=${install_git:-y}

if [[ "$install_git" == "y" || "$install_git" == "Y" ]]; then
    sudo apt install git -y
else
    echo "Skipping Git installation."
fi

read -p "Do you want to install zsh and ohmyzsh? (Y/n): " install_ohmyzsh
install_ohmyzsh=${install_ohmyzsh:-y}

if [[ "$install_ohmyzsh" == "y" || "$install_ohmyzsh" == "Y" ]]; then
    sudo apt install zsh -y
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

    read -p "Do you want to install zsh-autosuggestions? (Y/n): " install_zsh_autosuggestions
    install_zsh_autosuggestions=${install_zsh_autosuggestions:-y}

    if [[ "$install_zsh_autosuggestions" == "y" || "$install_zsh_autosuggestions" == "Y" ]]; then
        git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
        echo "source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh" >> ~/.zshrc
        echo -e "${GREEN_COLOR}zsh-autosuggestions has been installed successfully.${NO_COLOR}"
    fi

    read -p "Do you want to install zsh-syntax-highlighting? (Y/n): " install_zsh_syntax_highlighting
    install_zsh_syntax_highlighting=${install_zsh_syntax_highlighting:-y}

    if [[ "$install_zsh_syntax_highlighting" == "y" || "$install_zsh_syntax_highlighting" == "Y" ]]; then
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
        echo "source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ~/.zshrc
        echo -e "${GREEN_COLOR}zsh-syntax-highlighting has been installed successfully.${NO_COLOR}"
    fi

    read -p "Do you want to install fzf autocomplete? (Y/n): " install_fzf
    install_fzf=${install_fzf:-y}

    if [[ "$install_fzf" == "y" || "$install_fzf" == "Y" ]]; then
        git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
        ~/.fzf/install
        echo -e "${GREEN_COLOR}fzf has been installed successfully.${NO_COLOR}"
    fi

    echo -e "${GREEN_COLOR}zsh and ohmyzsh have been installed successfully.${NO_COLOR}"

else
    echo "Skipping ohmyzsh installation."
fi

read -p "Do you want to install eza? (Y/n): " install_eza
install_eza=${install_eza:-y}

if [[ "$install_eza" == "y" || "$install_eza" == "Y" ]]; then
    sudo apt install -y gpg
    sudo mkdir -p /etc/apt/keyrings
    wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
    echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
    sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
    sudo apt update
    sudo apt install -y eza
    echo -e "${GREEN_COLOR}eza has been installed successfully.${NO_COLOR}"
else
    echo "Skipping eza installation."
fi

read -p "Do you want to install Docker and Docker compose? (Y/n): " install_docker
install_docker=${install_docker:-y}

if [[ "$install_docker" == "y" || "$install_docker" == "Y" ]]; then
    sudo apt-get install ca-certificates curl
    sudo install -m 0755 -d /etc/apt/keyrings
    sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
    sudo chmod a+r /etc/apt/keyrings/docker.asc

    # Add the repository to Apt sources:
    echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
    $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update

    # Install Docker
    sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

    sudo usermod -aG docker $USER
    sudo systemctl enable docker
    sudo systemctl start docker
    
    sudo apt-get install docker-compose-plugin -y
    echo -e "${GREEN_COLOR}Docker and Docker compose have been installed successfully.${NO_COLOR}"
    echo -e "${GREEN_COLOR}Docker has been installed successfully.${NO_COLOR}"

else
    echo "Skipping Docker installation."
fi

read -p "Do you want to install neofetch (Y/n): " install_neofetch
install_neofetch=${install_neofetch:-y}

if [[ "$install_neofetch" == "y" || "$install_neofetch" == "Y" ]]; then
    sudo apt install neofetch -y
    sudo apt install figlet -y

    read -p "Enter the text you want to display with figlet: " figlet_text
    figlet_text=${figlet_text:-$(whoami)}

    echo "figlet -c ${figlet_text} | xargs -0 printf '\033[0;31m%s'" >> ~/.zshrc
    echo "printf '\n'" >> ~/.zshrc
    echo "neofetch" >> ~/.zshrc

    read -p "Do you want load custom neofetch config?: " load_neofetch_config
    load_neofetch_config=${load_neofetch_config:-y}
    
    if [[ "$load_neofetch_config" == "y" || "$load_neofetch_config" == "Y" ]]; then
        wget -O ~/.config/neofetch/config.conf link
        wget -O ~/.config/neofetch/logo link
        echo -e "${GREEN_COLOR}neofetch config has been loaded successfully.${NO_COLOR}"
    fi

    echo -e "${GREEN_COLOR}neofetch has been installed successfully.${NO_COLOR}"
else
    echo "Skipping neofetch installation."
fi

read -p "Do you want to install htop (Y/n): " install_htop
install_htop=${install_htop:-y}

if [[ "$install_htop" == "y" || "$install_htop" == "Y" ]]; then
    sudo apt install htop -y
    echo -e "${GREEN_COLOR}htop has been installed successfully.${NO_COLOR}"
else
    echo "Skipping htop installation."
fi

echo -e "${CYAN_COLOR}GUI section${NO_COLOR}"

read -p "Do you want to skip this part? (y/N): " skip_gui
skip_gui=${skip_gui:-n}

if [[ "$skip_gui" == "y" || "$skip_gui" == "Y" ]]; then
    echo "Skipping GUI installation."
    exit 0
fi

read -p "Do you want to install VLC media player? (Y/n): " install_vlc
install_vlc=${install_vlc:-y}

if [[ "$install_vlc" == "y" || "$install_vlc" == "Y" ]]; then
    sudo apt install vlc -y
    echo -e "${GREEN_COLOR}VLC media player has been installed successfully.${NO_COLOR}"
else
    echo "Skipping VLC media player installation."
fi

read -p "Do you want to install Wireguard & AmneziaVPN? (Y/n): " install_wireguard
install_wireguard=${install_wireguard:-y}

if [[ "$install_wireguard" == "y" || "$install_wireguard" == "Y" ]]; then
    sudo apt install wireguard libxcb-xinerama0 libxcb-cursor0 -y

    # Install AmneziaVPN
    echo -e "${RED_COLOR}Installing AmneziaVPN can be only manuall${NO_COLOR}"

    echo -e "${GREEN_COLOR}Wireguard has been installed successfully.${NO_COLOR}"
else
    echo "Skipping Wireguard installation."
fi

read -p "Do you want to install Telegram? (Y/n): " install_tg
install_tg=${install_tg:-y}

if [[ "$install_tg" == "y" || "$install_tg" == "Y" ]]; then
    sudo apt install telegram-desktop -y
    echo -e "${GREEN_COLOR}Telegram has been installed successfully.${NO_COLOR}"
else
    echo "Skipping Telegram installation."
fi

read -p "Do you want to install VSCode? (Y/n): " install_code
install_code=${install_code:-y}

if [[ "$install_code" == "y" || "$install_code" == "Y" ]]; then
    sudo apt install code -y
    echo -e "${GREEN_COLOR}VSCode has been installed successfully.${NO_COLOR}"
else
    echo "Skipping VSCode installation."
fi

echo -e "${GREEN_COLOR}All the software has been installed successfully.${NO_COLOR}"
echo -e "${GREEN_COLOR}Please restart your system to apply the changes.${NO_COLOR}"
