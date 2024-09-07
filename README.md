# Opera Stable For Arch Linux

## Installation

You can install the Opera Stable package from this repository using one of the following methods:

### Clone and Install Directly

1. **Clone the repository:**

    ```bash
    git clone https://github.com/nhktmdzhg/opera-aur-arch.git
    cd opera-aur-arch
    ```

2. **Build and Install the Package:**

    ```bash
    makepkg -si
    ```

    This command will build the package from the `PKGBUILD` file and install the newly created package.

### Using AUR Helpers

Although this repository is not hosted on AUR, you can still use AUR helpers if you manually add the `PKGBUILD` to your local AUR helper's cache:

1. **For Pikaur:**

    ```bash
    pikaur -Pi
    ```

2. **For Yay and Paru:**

    I don't know because I don't use it, haha. Please refer to the respective documentation.
