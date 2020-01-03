#
PKG       := pkg.dll
DST       := bundle
JS        := $(DST)/main.js
CSS       := $(DST)/style.css

# Files to be packaged into DLL
FILES_SRC := $(JS) $(CSS) $(DST)/index.html $(DST)/polyfill.js

###########################
# FOR ENTRYPED HTML/JS/CSS, IF make PASSWD=xxxxxx
CTR_DIR          := $(DST)/ctr
CTR_FILES        := $(addprefix $(CTR_DIR)/,$(addsuffix .ctr, $(notdir $(FILES_SRC))))
CTR_SHA1HASH     := rc/sha1hash.h
PKG_DEPENDENCIES := $(if $(value PASSWD),$(CTR_SHA1HASH) $(CTR_DIR) $(CTR_FILES), $(FILES_SRC))
BAT_ARGUMENT     := $(if $(value PASSWD),ENCRYPT,)
###########################

all: $(JS) $(CSS) $(PKG)

clean:
	rm -rf $(JS) $(CSS) $(PKG) rc/pkg.res $(CTR_SHA1HASH) $(CTR_DIR) 

.PHONY: all clean ctr_run FORCE

HAXESRC := $(wildcard src/*.hx)
$(JS): build.hxml $(HAXESRC)
	haxe build.hxml

HSSSRC  := $(wildcard hss/*.hss)
$(CSS): $(HSSSRC)
	hss -output $(DST) $^

$(PKG) : rc/pkg.rc $(PKG_DEPENDENCIES)
	@cd rc && cmd /c build.bat $(BAT_ARGUMENT)
	@echo ">" $@

$(CTR_DIR):
	@-mkdir -p $@

# Uses FORCE since passwd is dynamic
$(CTR_SHA1HASH): FORCE
	@haxelib run mix -k $(PASSWD) -o $(dir $@) --header

$(CTR_FILES): ctr_run

# The value of $^ will omits duplicate prerequisites,
ctr_run: $(FILES_SRC)
	@haxelib run mix -k $(PASSWD) -o $(CTR_DIR) $^

FORCE:;
