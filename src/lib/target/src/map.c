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

