# REGEX
REGEX_VERSION := 0.13
REGEX_URL := $(CONTRIB_VIDEOLAN)/regex-$(REGEX_VERSION).tar.gz

ifndef HAVE_WIN32
# Part of POSIX.2001
PKGS_FOUND += regex
endif

$(TARBALLS)/regex-$(REGEX_VERSION).tar.gz:
	$(call download,$(REGEX_URL))

.sum-regex: regex-$(REGEX_VERSION).tar.gz

regex: regex-$(REGEX_VERSION).tar.gz .sum-regex
	$(UNPACK)
	$(MOVE)

.regex: regex
	cd $< && $(HOSTVARS) ./configure $(HOSTCONF)
	cd $< && $(MAKE) subirs=
	cd $< && $(AR) rcvu libregex.a regex.o && $(RANLIB) libregex.a && cp -v regex.h $(PREFIX)/include && cp -v libregex.a $(PREFIX)/lib
	touch $@
