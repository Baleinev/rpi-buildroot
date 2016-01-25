################################################################################
#
# FREEIMAGE
#
################################################################################


FREEIMAGE_VERSION = 3170
FREEIMAGE_SITE = http://downloads.sourceforge.net/project/freeimage/Source%20Distribution/3.17.0
FREEIMAGE_SOURCE = FreeImage$(FREEIMAGE_VERSION).zip
FREEIMAGE_INSTALL_STAGING = YES
FREEIMAGE_LICENSE = BSD-2c
FREEIMAGE_LICENSE_FILES = License.txt

FREEIMAGE_CXXFLAGS = $(TARGET_CFLAGS) -DNDEBUG


ifeq ($(BR2_STATIC_LIBS),y)
FREEIMAGE_MAKE_OPTS += SHARED=0 -f Makefile.gnu
else
FREEIMAGE_MAKE_OPTS += SHARED=1 -f Makefile.gnu
FREEIMAGE_CXXFLAGS += -fPIC  -ISource -ISource/OpenEXR/Imath/ -ISource/OpenEXR/  -ISource/OpenEXR/Half/ -ISource/OpenEXR/Iex/ -ISource/LibJXR/jxrgluelib -ISource/LibJXR/image/sys -ISource/LibJXR/common/include -ISource/OpenEXR/IlmImf -ISource/OpenEXR/IlmThread -ISource/OpenEXR/IexMath -ISource/LibRawLite/ -D__ANSI__
FREEIMAGE_CFLAGS += -fPIC   -ISource -ISource/OpenEXR/Imath/ -ISource/OpenEXR/ -ISource/OpenEXR/Half/ -ISource/OpenEXR/Iex/ -ISource/LibJXR/jxrgluelib -ISource/LibJXR/image/sys -ISource/LibJXR/common/include -ISource/OpenEXR/IlmImf -ISource/OpenEXR/IlmThread -ISource/OpenEXR/IexMath -ISource/LibRawLite/ -D__ANSI__
endif

FREEIMAGE_MAKE_OPTS += BUILD_TYPE= CXXFLAGS="$(FREEIMAGE_CXXFLAGS)" CFLAGS="$(FREEIMAGE_CFLAGS)"

define FREEIMAGE_EXTRACT_CMDS
	$(UNZIP) -d $(@D) $(DL_DIR)/$(FREEIMAGE_SOURCE)
	mv $(@D)/FreeImage/* $(@D)
	$(RM) -r $(@D)/FreeImage
#	$(SED) '/ldconfig/d' $(@D)/makefile
endef

define FREEIMAGE_BUILD_CMDS
	mkdir -p $(@D)/Objects_$(if $(BR2_STATIC_LIBS),static,shared) \
		$(@D)/_internal/Source/Dependencies
	$(TARGET_MAKE_ENV) $(MAKE) $(TARGET_CONFIGURE_OPTS) \
		$(FREEIMAGE_MAKE_OPTS) -C $(@D)
endef

define FREEIMAGE_INSTALL_TARGET_CMDS
	cp $(@D)/Dist/lib*  $(TARGET_DIR)/usr/lib/

endef

define FREEIMAGE_INSTALL_STAGING_CMDS
	cp $(@D)/Dist/lib* $(STAGING_DIR)/usr/lib/
	cp $(@D)/Dist/*.h  $(STAGING_DIR)/usr/include/
endef

$(eval $(generic-package))
