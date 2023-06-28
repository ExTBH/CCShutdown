ARCHS = arm64
TARGET := iphone:clang:14.5:14.0
INSTALL_TARGET_PROCESSES = SpringBoard
include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = CCShutdown
CCShutdown_BUNDLE_EXTENSION = bundle
CCShutdown_FILES =  $(wildcard *.m)
CCShutdown_CFLAGS = -fobjc-arc
CCShutdown_FRAMEWORKS = UIKit CydiaSubstrate
CCShutdown_PRIVATE_FRAMEWORKS = ControlCenterUIKit
CCShutdown_INSTALL_PATH = /Library/ControlCenter/Bundles/

include $(THEOS_MAKE_PATH)/bundle.mk
