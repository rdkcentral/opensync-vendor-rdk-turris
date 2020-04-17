/*
If not stated otherwise in this file or this component's LICENSE
file the following copyright and licenses apply:

Copyright [2019] [RDK Management]

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/
/*
Copyright (c) 2019, Plume Design Inc. All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:
   1. Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
   2. Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
   3. Neither the name of the Plume Design Inc. nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL Plume Design Inc. BE LIABLE FOR ANY
DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.


The OSYNC HAL abstracts all hardware / system-level functions of the target
that are not (yet) included in RDK API. Some of the APIs from this file can
be a part of RDK (or similar) HAL API in the future.
*/

#include <stdio.h>
#include <string.h>
#include <fcntl.h>
#include <ctype.h>
#include <stdbool.h>
#include <errno.h>

#include "log.h"
#include "target.h"

typedef struct
{
    uint8_t  vif_radio_idx;
    char     *cloud_ifname;
    char     *device_ifname;
    char     *bridge;
    char     *gre_bridge;
    uint16_t vlan_id;
} ifmap_t;

static ifmap_t  ifmap[] = {
//    idx   cloud-ifname     dev-ifname  bridge    gre-br            vlan     description
    { 1,    "bhaul-ap-24",   "wifi2",    "brlan0", "wifi2", 0 },  // 2G Backhaul
    { 1,    "bhaul-ap-50",   "wifi3",    "brlan0", "wifi3",  0 },  // 5G Backhaul
    { 2,    "home-ap-24",    "wifi0",    "brlan0",  NULL,            0 },  // 2G User SSID
    { 2,    "home-ap-50",    "wifi1",    "brlan0",  NULL,            0 },  // 5G User SSID
    { 0,    NULL,            NULL,        NULL,     NULL,            0 }
};

bool target_map_ifname_init(void)
{
    static bool     init = false;
    ifmap_t         *mp;

    if (init == true)
    {
        return true;
    }
    init = true;
    target_map_init();

    // Register cloud <-> device interface mappings

    mp = ifmap;
    while (mp->device_ifname != NULL)
    {
        target_map_insert(mp->cloud_ifname, mp->device_ifname);

        mp++;
    }

    return true;
}

char* target_map_ifname_to_bridge(const char *ifname)
{
    ifmap_t         *mp;

    mp = ifmap;
    while (mp->device_ifname != NULL)
    {
        if (!strcmp(ifname, mp->device_ifname) || !strcmp(ifname, mp->cloud_ifname))
        {
            return mp->bridge;
        }

        mp++;;
    }

    return NULL;
}

char* target_map_ifname_to_gre_bridge(const char *ifname)
{
    ifmap_t         *mp;

    mp = ifmap;
    while(mp->device_ifname != NULL)
    {
        if (!strcmp(ifname, mp->device_ifname) || !strcmp(ifname, mp->cloud_ifname))
        {
            return mp->gre_bridge;
        }

        mp++;;
    }

    return NULL;
}

uint16_t target_map_ifname_to_vlan(const char *ifname)
{
    ifmap_t         *mp;

    mp = ifmap;
    while (mp->device_ifname != NULL)
    {
        if (!strcmp(ifname, mp->device_ifname) || !strcmp(ifname, mp->cloud_ifname))
        {
            return mp->vlan_id;
        }

        mp++;;
    }

    return 0;
}

uint8_t target_map_ifname_to_vif_radio_idx(const char *ifname)
{
    ifmap_t         *mp;

    mp = ifmap;
    while (mp->device_ifname != NULL)
    {
        if (!strcmp(ifname, mp->device_ifname) || !strcmp(ifname, mp->cloud_ifname))
        {
            return mp->vif_radio_idx;
        }

        mp++;;
    }

    return 0;
}

uint16_t target_map_bridge_to_vlan(const char *bridge)
{
    ifmap_t         *mp;

    mp = ifmap;
    while (mp->device_ifname != NULL)
    {
        if (!strcmp(bridge, mp->bridge))
        {
            return mp->vlan_id;
        }

        mp++;;
    }

    return 0;
}

char *target_map_vlan_to_bridge(uint16_t vlan_id)
{
    ifmap_t         *mp;

    mp = ifmap;
    while (mp->device_ifname != NULL)
    {
        if (vlan_id == mp->vlan_id)
        {
            return mp->bridge;
        }

        mp++;;
    }

    return NULL;
}

bool target_map_update_vlan(const char *ifname, uint16_t vlan_id)
{
    ifmap_t         *mp;

    mp = ifmap;
    while (mp->device_ifname != NULL)
    {
        if (!strcmp(ifname, mp->device_ifname) || !strcmp(ifname, mp->cloud_ifname))
        {
            mp->vlan_id = vlan_id;
            return true;
        }

        mp++;;
    }

    return false;
}

