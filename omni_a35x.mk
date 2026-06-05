name: SHRP-Reborn Recovery Build (A35X)

on:
  workflow_dispatch:
    inputs:
      DEVICE:
        description: "Device codename"
        required: true
        default: "a35x"

jobs:
  build:
    runs-on: ubuntu-22.04

    env:
      USE_CCACHE: 1
      CCACHE_COMPRESS: 1
      CCACHE_MAXSIZE: 5G

    steps:

    # =========================
    # 🔥 FREE DISK SPACE (IMPORTANT)
    # =========================
    - name: Free disk space
      run: |
        sudo rm -rf /usr/share/dotnet
        sudo rm -rf /opt/ghc
        sudo rm -rf /usr/local/lib/android
        sudo apt-get clean
        sudo rm -rf /var/lib/apt/lists/*
        sudo rm -rf /tmp/*
        df -h

    # =========================
    # 📦 DEPENDENCIES
    # =========================
    - name: Install packages
      run: |
        sudo apt update
        sudo apt install -y git curl zip unzip wget bc python3 repo

    # =========================
    # 📥 INIT SHRP-REBORN (UPDATED)
    # =========================
    - name: Init repo (SHRP-Reborn)
      run: |
        mkdir shrp && cd shrp
        repo init -u https://github.com/SHRP-Reborn/manifest.git -b shrp-12.1 --depth=1

    # =========================
    # 🔄 SYNC SOURCE (LIGHT)
    # =========================
    - name: Sync repo
      run: |
        cd shrp
        repo sync -c --no-tags --no-clone-bundle --force-sync -j2

    # =========================
    # 📱 DEVICE TREE (A35X)
    # =========================
    - name: Clone device tree
      run: |
        cd shrp
        git clone https://github.com/christiandroid20/android_device_samsung_a54x device/samsung/a35x

    # =========================
    # ⚙️ BUILD ENV
    # =========================
    - name: Setup build environment
      run: |
        cd shrp
        source build/envsetup.sh
        lunch omni_a35x-eng

    # =========================
    # 🚀 BUILD RECOVERY
    # =========================
    - name: Build recovery
      run: |
        cd shrp
        export LC_ALL=C
        export ALLOW_MISSING_DEPENDENCIES=true
        export TZ=UTC

        mka recoveryimage -j2

    # =========================
    # 📤 UPLOAD ARTIFACT
    # =========================
    - name: Upload recovery
      uses: actions/upload-artifact@v4
      with:
        name: SHRP-Reborn-A35X
        path: |
          shrp/out/target/product/*/recovery.img
