export TARGET = iphone:clang:14.5:14.5
INSTALL_TARGET_PROCESSES = SpringBoard
ARCHS = arm64 arm64e

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = SnoozeLabels

SnoozeLabels_FILES = Tweak.xm
SnoozeLabels_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
