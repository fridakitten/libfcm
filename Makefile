# Makefile

SDK_PATH = sdks/iPhoneOS15.6.sdk

ifeq ($(wildcard /bin/sh),)
ifeq ($(wildcard /var/jb/bin/sh),)
$(error "Neither /bin/sh nor /var/jb/bin/sh found.")
endif
SHELL := /var/jb/bin/sh
else
SHELL := /bin/sh
endif

ifeq ($(wildcard $(SDK_PATH)),)
sdk_marker := .sdk_not_exists
.PHONY: create
create:
	@git clone https://github.com/theos/sdks.git
	@make all
endif

all:
	@clang -isysroot $(SDK_PATH) -framework UIKit -framework Foundation -target arm64-apple-ios15.0 -c libfcm.m -o libfcm.a