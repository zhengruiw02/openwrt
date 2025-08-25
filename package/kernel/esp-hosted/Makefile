include $(TOPDIR)/rules.mk

PKG_NAME:=esp-hosted
PKG_VERSION:=1.0
PKG_RELEASE=1

PKG_LICENSE:=GPLv2
PKG_LICENSE_FILES:=

# PKG_MAINTAINER:=
PKG_USE_NINJA:=0
PKG_BUILD_PARALLEL:=1

PKG_CONFIG_DEPENDS += \
	CONFIG_PACKAGE_CFG80211_TESTMODE

STAMP_CONFIGURED_DEPENDS := $(STAGING_DIR)/usr/include/mac80211-backport/backport/autoconf.h

include $(INCLUDE_DIR)/kernel.mk
include $(INCLUDE_DIR)/package.mk


define KernelPackage/esp-default
  SUBMENU:=Wireless Drivers
  DEPENDS:= \
	+kmod-mac80211 \
	+@KERNEL_PAGE_POOL \
	@!TARGET_uml
endef

define KernelPackage/esp32-sdio
	$(KernelPackage/esp-default)
	SUBMENU:=Wireless Drivers
	TITLE:=ESP32 SDIO wireless driver (metapackage)
	DEPENDS:= \
		+kmod-mmc +kmod-bluetooth +kmod-mac80211 +kmod-cfg80211
	FILES:=$(PKG_BUILD_DIR)/esp32_sdio.ko
	AUTOLOAD:=$(call AutoProbe,esp32_sdio)
	PROVIDES:=kmod-esp32-sdio
endef

define KernelPackage/esp32-sdio/description
  This package contains the ESP32 SDIO wireless driver for OpenWrt.
  It enables WiFi connectivity using ESP32 modules connected via SDIO interface.
endef

TARGET_CFLAGS += -I$(STAGING_DIR)/usr/include/libnl-tiny

NOSTDINC_FLAGS := \
	$(KERNEL_NOSTDINC_FLAGS) \
	-I$(PKG_BUILD_DIR) \
	-I$(STAGING_DIR)/usr/include/mac80211-backport/uapi \
	-I$(STAGING_DIR)/usr/include/mac80211-backport \
	-I$(STAGING_DIR)/usr/include/mac80211/uapi \
	-I$(STAGING_DIR)/usr/include/mac80211 \
	-include backport/autoconf.h \
	-include backport/backport.h

ifdef CONFIG_PACKAGE_MAC80211_MESH
  NOSTDINC_FLAGS += -DCONFIG_MAC80211_MESH
endif

ifdef CONFIG_PACKAGE_CFG80211_TESTMODE
  NOSTDINC_FLAGS += -DCONFIG_NL80211_TESTMODE
  PKG_MAKE_FLAGS += CONFIG_NL80211_TESTMODE=y
endif

ifdef CONFIG_PACKAGE_kmod-esp32-sdio
  PKG_MAKE_FLAGS += CONFIG_ESP_SDIO=m
endif

# define Build/Prepare
# 	$(call Build/Prepare/Default)
	
# 	if [ ! -d "./src" ]; then \
# 		echo "ERROR: src/ directory not found!"; \
# 		exit 1; \
# 	fi
	
# 	$(CP) ./src/* $(PKG_BUILD_DIR)/
	
# 	if [ ! -f "$(PKG_BUILD_DIR)/Makefile" ]; then \
# 		echo "ERROR: Kernel module Makefile not found in src/"; \
# 		exit 1; \
# 	fi
# endef

define Build/Compile
	+$(KERNEL_MAKE) $(PKG_JOBS) \
		$(PKG_MAKE_FLAGS) \
		M="$(PKG_BUILD_DIR)" \
		NOSTDINC_FLAGS="$(NOSTDINC_FLAGS)" \
		modules
endef

$(eval $(call KernelPackage,esp32-sdio))