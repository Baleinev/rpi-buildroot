################################################################################
#
# libass
#
################################################################################

LIBASS_VERSION = 0.12.3
LIBASS_SOURCE = libass-$(LIBASS_VERSION).tar.xz
# Do not use the github helper here, the generated tarball is *NOT*
# the same as the one uploaded by upstream for the release.
LIBASS_SITE = https://github.com/libass/libass/releases/download/$(LIBASS_VERSION)
LIBASS_INSTALL_STAGING = YES
LIBASS_LICENSE = ISC
LIBASS_LICENSE_FILES = COPYING
LIBASS_DEPENDENCIES = \
	host-pkgconf \
	freetype \
	libfribidi \
	$(if $(BR2_PACKAGE_LIBICONV),libiconv)

# configure: WARNING: Install yasm for a significantly faster libass build.
# only for Intel archs
ifeq ($(BR2_i386)$(BR2_x86_64),y)
LIBASS_DEPENDENCIES += host-yasm
endif

ifeq ($(BR2_PACKAGE_FONTCONFIG),y)
LIBASS_DEPENDENCIES += fontconfig
LIBASS_CONF_OPTS += --enable-fontconfig
else
LIBASS_CONF_OPTS += --disable-fontconfig
endif

ifeq ($(BR2_PACKAGE_HARFBUZZ),y)
LIBASS_DEPENDENCIES += harfbuzz
LIBASS_CONF_OPTS += --enable-harfbuzz
else
LIBASS_CONF_OPTS += --disable-harfbuzz
endif

ifeq ($(BR2_PACKAGE_LIBENCA),y)
LIBASS_DEPENDENCIES += libenca
LIBASS_CONF_OPTS += --enable-enca
else
LIBASS_CONF_OPTS += --disable-enca
endif

$(eval $(autotools-package))
