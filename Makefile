TARGET := iphone:clang:latest:14.0
INSTALL_TARGET_PROCESSES = LastIsland

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = AIProMenu

AIProMenu_FILES = Tweak.mm
AIProMenu_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
