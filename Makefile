#
PKG       := pkg.dll
DST       := bundle
JS        := $(DST)/main.js
CSS       := $(DST)/style.css

# Files to be packaged into DLL
FILES_SRC := $(DST)/index.html $(DST)/polyfill.js $(JS) $(CSS)

all: $(JS) $(CSS) $(PKG)

clean:
	rm -rf $(JS) $(CSS) $(PKG) rc/pkg.res

.PHONY: all clean FORCE

HAXESRC := $(wildcard src/*.hx)
$(JS): build.hxml $(HAXESRC)
	haxe build.hxml

$(CSS): hss/style.hss
	hss -output $(DST) $<

$(PKG): rc/pkg.rc $(FILES_SRC)
	@cd rc && cmd /c build.bat
	@echo ">" $@
