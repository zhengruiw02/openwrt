# SPDX-License-Identifier: GPL-2.0


# Module name (default: sdio)
target ?= sdio
MODULE_NAME := esp32_$(target)
MAPFILE := $(MODULE_NAME).map

ccflags-y += -I$(src) -I$(src)/include

# Interface-specific sources
ifeq ($(target), sdio)
    ccflags-y += -I$(src)/sdio
    EXTRA_CFLAGS += -I$(M)/sdio
    module_objects += sdio/esp_sdio.o sdio/esp_sdio_api.o
endif

ifeq ($(target), spi)
    ccflags-y += -I$(src)/spi
    EXTRA_CFLAGS += -I$(M)/spi
    module_objects += spi/esp_spi.o
endif

obj-$(CONFIG_ESP_SDIO)		+= $(MODULE_NAME).o

# Common source files
module_objects += esp_bt.o main.o esp_cmd.o esp_utils.o esp_cfg80211.o esp_stats.o esp_debugfs.o esp_log.o
CFLAGS_esp_log.o = -DDEBUG

# Module build rules
obj-m := $(MODULE_NAME).o
$(MODULE_NAME)-y := $(module_objects)
