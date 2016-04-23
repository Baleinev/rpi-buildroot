#############################################################
#
# pmw-vidplayer
#
#############################################################
PMW_VIDPLAYER_VERSION = master
PMW_VIDPLAYER_SITE_METHOD = git
PMW_VIDPLAYER_SITE = https://N3odyme@github.com/floriansegginger/pmw-modules.git
PMW_VIDPLAYER_INSTALL_STAGING = NO
PMW_VIDPLAYER_DEPENDENCIES = ffmpeg libopenmax libegl libgles bzip2

define PMW_VIDPLAYER_BUILD_CMDS
	$(MAKE) CC=$(TARGET_CC) CXX=$(TARGET_CXX) LD=$(TARGET_LD) -C $(@D) all
endef

define PMW_VIDPLAYER_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/vidplayer/vidplayer $(TARGET_DIR)/usr/bin/pmw-vidplayer
	$(INSTALL) -D -m 0755 $(@D)/fireworks/fireworks $(TARGET_DIR)/usr/bin/pmw-fireworks
endef

$(eval $(generic-package))