# Ubuntu Configuration Script

# It is in the production stage.

This repository contains a script to automate the installation and configuration of various software packages on an Ubuntu system.

## Features

- **System Update**: Updates the package list, upgrades installed packages, removes unnecessary packages, and cleans up the local repository.
- **Git**: Option to install Git.
- **Zsh and Oh My Zsh**: Option to install Zsh, Oh My Zsh, and plugins like `zsh-autosuggestions`, `zsh-syntax-highlighting`, and `fzf`.
- **eza**: Option to install `eza`, a modern replacement for `ls`.
- **Docker**: Option to install Docker and Docker Compose.
- **Neofetch**: Option to install Neofetch and Figlet, with an option to load a custom Neofetch configuration.
- **htop**: Option to install `htop`.
- **GUI Applications**: Options to install VLC media player, Wireguard, AmneziaVPN, Telegram, and VSCode.

## Usage

1. Clone the repository:

   ```bash
   git clone https://github.com/yourusername/ubuntu-config.git
   cd ubuntu-config
   ```

2. Make the script executable:

   ```bash
   chmod +x install.sh
   ```

3. Run the script:

   ```bash
   ./install.sh
   ```

   The script will prompt you for various installation options. You can choose to install or skip each software package.

## Notes

- Ensure you have an active internet connection as the script will download packages and configurations from the internet.
- Some installations may require additional user input or manual steps, especially for GUI applications.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Contributing

Contributions are welcome! Please open an issue or submit a pull request for any improvements or bug fixes.

## Acknowledgements

- [Oh My Zsh](https://ohmyz.sh/)
- [eza](https://github.com/eza-community/eza)
- [Docker](https://www.docker.com/)
- [Neofetch](https://github.com/dylanaraps/neofetch)
- [htop](https://htop.dev/)
- [VLC](https://www.videolan.org/vlc/)
- [Wireguard](https://www.wireguard.com/)
- [Telegram](https://desktop.telegram.org/)
- [VSCode](https://code.visualstudio.com/)
