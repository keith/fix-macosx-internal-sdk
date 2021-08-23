PREFIX=/usr/local

install:
	swift build -c release --arch arm64 --arch x86_64
	mkdir -p "$(PREFIX)/bin"
	cp -f .build/apple/Products/Release/fix-macosx-internal-sdk "$(PREFIX)/bin"

format:
	swift package _format
