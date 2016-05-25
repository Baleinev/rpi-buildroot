#############################################################
#
# pmw-modules
#
#############################################################
PMW_MODULES_VERSION = master
PMW_MODULES_SITE_METHOD = git
PMW_MODULES_SITE = https://N3odyme@github.com/floriansegginger/pmw-modules.git
PMW_MODULES_INSTALL_STAGING = NO
PMW_MODULES_DEPENDENCIES = ffmpeg libopenmax libegl libgles bzip2

define PMW_MODULES_BUILD_CMDS
	$(MAKE) CC=$(TARGET_CC) CXX=$(TARGET_CXX) LD=$(TARGET_LD) -C $(@D) all
endef

define PMW_MODULES_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/vidplayer/vidplayer $(TARGET_DIR)/usr/bin/pmw-vidplayer
	$(INSTALL) -D -m 0755 $(@D)/fireworks/fireworks $(TARGET_DIR)/usr/bin/pmw-fireworks
	$(INSTALL) -D -m 0755 $(@D)/screenshot/screenshot $(TARGET_DIR)/usr/bin/pmw-screenshot
endef

$(eval $(generic-package))