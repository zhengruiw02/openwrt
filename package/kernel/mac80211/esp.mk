PKG_DRIVERS += esp32_sdio

config-$(call config_package,esp32_sdio) += ESP_HOSTED_NG

define KernelPackage/esp32_sdio
  $(call KernelPackage/mac80211/Default)
  TITLE:=ESP host Wireless support
  DEPENDS:= +kmod-mac80211 +kmod-bluetooth +kmod-mmc
  FILES:=$(PKG_BUILD_DIR)/drivers/net/wireless/esp/host/esp32_sdio.ko
  AUTOLOAD:=$(call AutoProbe,esp32_sdio)
endef
