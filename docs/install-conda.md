## Conda is now bug you need to use miniconda instead
```bash
==> WARNING: Possibly missing firmware for module: 'xhci_pci'
-> Running build hook: [keymap]
-> Running build hook: [modconf]
-> Running build hook: [block]
==> WARNING: Possibly missing firmware for module: 'qla1280'
==> WARNING: Possibly missing firmware for module: 'aic94xx'
==> WARNING: Possibly missing firmware for module: 'qla2xxx'
==> WARNING: Possibly missing firmware for module: 'qed'
==> WARNING: Possibly missing firmware for module: 'bfa'
==> WARNING: Possibly missing firmware for module: 'wd719x'
```
## Prerequisites: Setting the Stage

Before diving into installation, it’s crucial to prepare your system. Start by updating Arch Linux to ensure compatibility:

`sudo pacman -Syu`

Next, install the dependencies for Anaconda:

`sudo pacman -Sy python-pluggy python-pycosat python-ruamel-yaml`

Then you need to get this package from the AUR:

`git clone https://aur.archlinux.org/python-conda-package-handling.git && cd python-conda-package-handling
makepkg -is`

This will cover all the prerequisites for Conda in Arch Linux.

## Installing Conda: The Heart of the Process

With the prerequisites out of the way, we move to the core installation steps. Begin by obtaining the Anaconda package from the AUR:

`git clone https://aur.archlinux.org/python-conda.git && cd python-conda
makepkg -is`

Verify your installation by running:

`conda --version`

