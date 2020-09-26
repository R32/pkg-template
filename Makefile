#
PKG       := pkg.dll
DST       := bundle
JS        := $(DST)/main.js
CSS       := $(DST)/style.css

# Files to be packaged into DLL
FILES_SRC := $(DST)/index.html $(DST)/polyfill.js $(JS) $(CSS)

###########################
# FOR ENTRYPED HTML/JS/CSS, IF make PASSWD=xxxxxx
CTR_DIR          := $(DST)/ctr
CTR_FILES        := $(CTR_DIR)/index.html.ctr
PKG_DEPENDENCIES := $(if $(value PASSWD), $(CTR_DIR) $(CTR_FILES), $(FILES_SRC))
BAT_ARGUMENT     := $(if $(value PASSWD),ENCRYPT,)
###########################
all: $(JS) $(CSS) $(PKG)

clean:
	rm -rf $(JS) $(CSS) $(PKG) rc/pkg.res $(CTR_DIR)

.PHONY: all clean FORCE

HAXESRC := $(wildcard src/*.hx)
$(JS): build.hxml $(HAXESRC)
	haxe build.hxml

$(CSS): hss/style.hss
	hss -output $(DST) $<

$(PKG) : rc/pkg.rc $(PKG_DEPENDENCIES)
	@cd rc && cmd /c build.bat $(BAT_ARGUMENT)
	@echo ">" $@

$(CTR_DIR):
	@-mkdir -p $@

# "$<": is just the first dependency
$(CTR_FILES): $(FILES_SRC)
	@haxelib run mix -k $(PASSWD) -o $(CTR_DIR) $<



FORCE:;
