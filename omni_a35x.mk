#
# Copyright (C) 2024 The Android Open Source Project
# Copyright (C) 2024 The TWRP Open Source Project
#
# SPDX-License-Identifier: Apache-2.0
#

# =========================
# CONFIG BÁSICA DEL DEVICE
# =========================

PRODUCT_PLATFORM := erd8835

# Nombre fijo del device (evita errores de parsing)
PRODUCT_RELEASE_NAME := a35x

# Vendor del árbol (AJUSTA si usas otro)
CUSTOM_VENDOR := shrp

# OEM / fabricante real del device
BOARD_VENDOR := samsung

# =========================
# IDENTIFICADORES DEL BUILD
# =========================

PRODUCT_DEVICE := $(PRODUCT_RELEASE_NAME)
PRODUCT_NAME := $(CUSTOM_VENDOR)_$(PRODUCT_DEVICE)
PRODUCT_BRAND := $(BOARD_VENDOR)
PRODUCT_MODEL := SAMSUNG_$(PRODUCT_DEVICE)
PRODUCT_MANUFACTURER := $(BOARD_VENDOR)

# Path del device
DEVICE_PATH := device/$(BOARD_VENDOR)/$(PRODUCT_DEVICE)

# =========================
# INHERIT BASE SYSTEM
# =========================

$(call inherit-product, $(SRC_TARGET_DIR)/product/base.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit_only.mk)

# =========================
# COMMON CONFIG (SHRP/TWRP)
# =========================

$(call inherit-product, vendor/$(CUSTOM_VENDOR)/config/common.mk)

# =========================
# DEVICE TREE
# =========================

$(call inherit-product, $(DEVICE_PATH)/device.mk)
