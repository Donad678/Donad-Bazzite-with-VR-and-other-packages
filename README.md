# Donad Bazzite VR Image

# Purpose

Modified Bazzite image, added build dependencies for what I use in Envision as well as building and installing envision itself

Also added a some programs, for personal use, might miss dependencies you need in Envision

The reason why Nvidia is the standard image is because thats what I use and set up first

# Rebasing

## NVIDIA

**GNOME:** ```rpm-ostree rebase ostree-image-signed:docker://ghcr.io/donad678/donad-bazzite-gnome:latest```

**KDE:** ```rpm-ostree rebase ostree-image-signed:docker://ghcr.io/donad678/donad-bazzite-kde:latest```

## AMD/Intel

**GNOME:** ```rpm-ostree rebase ostree-image-signed:docker://ghcr.io/donad678/donad-bazzite-gnome-mesa:latest```

**KDE:** ```rpm-ostree rebase ostree-image-signed:docker://ghcr.io/donad678/donad-bazzite-kde-mesa:latest```

# ISO

You can also download the ISO from the latest build artifact for a fresh install

https://github.com/Donad678/Donad-Bazzite-with-VR-and-other-packages/actions/workflows/build_iso.yml
