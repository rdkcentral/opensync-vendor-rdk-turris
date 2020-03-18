ifeq ($(TARGET),RDKB)

VENDOR = turris

BACKHAUL_SSID = "we.piranha"

CONTROLLER_PROTO = ssl
CONTROLLER_PORT = 443
CONTROLLER_HOST = "wildfire.plume.tech"

VERSION_NO_BUILDNUM = 1
VERSION_NO_SHA1 = 1
VERSION_NO_PROFILE = 1

#This vendor layer support Turris Omnia as a residential gateway and Turris omnia as Extender/GW
ifeq ($(RDK_MACHINE),$(filter $(RDK_MACHINE),turris turris-extender))

RDK_OEM = turris
RDK_MODEL = omnia

ifeq ($(RDK_MACHINE), turris-extender)
KCONFIG_TARGET ?= vendor/$(VENDOR)/kconfig/RDK_EXTENDER
RDK_CFLAGS  += -DTURRIS_POD
else
KCONFIG_TARGET ?= vendor/$(VENDOR)/kconfig/RDK
endif

else
$(error Unsupported RDK_MACHINE ($(RDK_MACHINE)).)
endif

endif
