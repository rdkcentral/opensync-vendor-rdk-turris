ifeq ($(TARGET),RDKB)

# TODO: Set correct vendor name
VENDOR = turris

BACKHAUL_SSID = "we.piranha"

CONTROLLER_PROTO = ssl
CONTROLLER_PORT = 443
CONTROLLER_HOST = "wildfire.plume.tech"

VERSION_NO_BUILDNUM = 1
VERSION_NO_SHA1 = 1
VERSION_NO_PROFILE = 1

# TODO: Set correct machine (it should equal to MACHINE variable from your Yocto build)
ifeq ($(RDK_MACHINE),turris)

# TODO: Set correct OEM and model names
RDK_OEM = turris
RDK_MODEL = omnia

KCONFIG_TARGET ?= platform/rdk/kconfig/RDK

# TODO: Specify additional CFLAGS if needed
#RDK_CFLAGS  +=

else ifeq ($(RDK_MACHINE),turris-pod)

# TODO: Set correct OEM and model names
RDK_OEM = turris
RDK_MODEL = omnia

# TODO: Specify additional CFLAGS if needed
RDK_CFLAGS  += -DTURRIS_POD

else
$(error Unsupported RDK_MACHINE ($(RDK_MACHINE)).)
endif

endif
