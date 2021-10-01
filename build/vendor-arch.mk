#If not stated otherwise in this file or this component's LICENSE
#file the following copyright and licenses apply:
#
#Copyright [2019] [RDK Management]
#
#Licensed under the Apache License, Version 2.0 (the "License");
#you may not use this file except in compliance with the License.
#You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
#Unless required by applicable law or agreed to in writing, software
#distributed under the License is distributed on an "AS IS" BASIS,
#WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#See the License for the specific language governing permissions and
#limitations under the License.

ifeq ($(TARGET),RDKB)

VENDOR = turris

CONTROLLER_PROTO = ssl
CONTROLLER_PORT = 443
CONTROLLER_HOST = "wildfire.plume.tech"

VERSION_NO_BUILDNUM = 1
VERSION_NO_SHA1 = 1
VERSION_NO_PROFILE = 1

#This vendor layer support Turris Omnia as a residential / business gateway and Turris omnia as Extender/GW
ifeq ($(RDK_MACHINE),$(filter $(RDK_MACHINE),turris turris-extender turris-bci turris_5.10))

RDK_OEM = turris
RDK_MODEL = omnia
SERVICE_PROVIDERS = ALL
export IMAGE_DEPLOYMENT_PROFILE = dev-academy

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
