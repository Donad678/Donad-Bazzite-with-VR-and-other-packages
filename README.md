# Donad Bazzite VR Image

# Purpose

Modified [Bazzite](https://github.com/ublue-os/bazzite) image, including precompiled monado, xrizer and opencomposite. I don't need the devel anymore as envision now supports using system binaries, so I added compilation of latest monado/xrizer git to the image build process so there is always an up to date build in the image. If you need build dependencies, build them with distrobox, you can then use that profile outside distrobox too

Also added a some programs, for personal use, might miss dependencies you need in Envision

The reason why Nvidia is the standard image is because thats what I use and set up first

Includes envision with dependencies for Wired headsets (valve index is what I'm using) and WiVRN Dashboard for standalone headsets

# Rebasing

## NVIDIA

**GNOME:** ```rpm-ostree rebase ostree-image-signed:docker://ghcr.io/donad678/donad-bazzite-gnome:latest```

**KDE:** ```rpm-ostree rebase ostree-image-signed:docker://ghcr.io/donad678/donad-bazzite-kde:latest```

## AMD/Intel

**GNOME:** ```rpm-ostree rebase ostree-image-signed:docker://ghcr.io/donad678/donad-bazzite-gnome-mesa:latest```

**KDE:** ```rpm-ostree rebase ostree-image-signed:docker://ghcr.io/donad678/donad-bazzite-kde-mesa:latest```

## Steam Deck

**GNOME:** ```rpm-ostree rebase ostree-image-signed:docker://ghcr.io/donad678/donad-bazzite-gnome-deck:latest```

**KDE:** ```rpm-ostree rebase ostree-image-signed:docker://ghcr.io/donad678/donad-bazzite-kde-deck:latest```

# ISO

## NVIDIA

You can download the latest iso here, it gets built weekly based on the latest available image

[**GNOME**](https://nightly.link/Donad678/Donad-Bazzite-with-VR-and-other-packages/workflows/build_iso/main/donad-bazzite-gnome-latest.zip), [**KDE**](https://nightly.link/Donad678/Donad-Bazzite-with-VR-and-other-packages/workflows/build_iso/main/donad-bazzite-kde-latest.zip)

## AMD/Intel

[**GNOME**](https://nightly.link/Donad678/Donad-Bazzite-with-VR-and-other-packages/workflows/build_iso/main/donad-bazzite-gnome-mesa-latest.zip), [**KDE**](https://nightly.link/Donad678/Donad-Bazzite-with-VR-and-other-packages/workflows/build_iso/main/donad-bazzite-kde-mesa-latest.zip)

## Steam Deck

[**GNOME**](https://nightly.link/Donad678/Donad-Bazzite-with-VR-and-other-packages/workflows/build_iso/main/donad-bazzite-gnome-deck-latest.zip), [**KDE**](https://nightly.link/Donad678/Donad-Bazzite-with-VR-and-other-packages/workflows/build_iso/main/donad-bazzite-kde-deck-latest.zip)


# Credits

Some files are from other repositories and cloned here for easier install, credit is to the original devs

[udev rule for valve index](https://github.com/MiguVT/fixvr/tree/main)

[Virtual Here Server](https://www.virtualhere.com)

[Lighthouse manager
](https://github.com/ShayBox/Lighthouse)

[xrizer](https://github.com/Supreeeme/xrizer)

While not outright copied I did use the code from the [wayvr pkgbuild on the aur](https://aur.archlinux.org/packages/wayvr-git) to make the wayvr compilation
