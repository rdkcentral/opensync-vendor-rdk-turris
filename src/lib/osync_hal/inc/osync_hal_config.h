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
#ifndef __OSYNC_HAL_CONFIG_H__
#define __OSYNC_HAL_CONFIG_H__

/*
 * Enable default osync_hal_...() API funcion by un-commenting
 * below macros:
 */

#define OSYNC_HAL_USE_DEFEAULT_FETCH_CONNECTED_CLIENTS
#define OSYNC_HAL_USE_DEFAULT_DEVINFO_GET_CLOUD_MODE
#define OSYNC_HAL_USE_DEFAULT_DEVINFO_GET_REDIRECTOR_ADDR
#define OSYNC_HAL_USE_DEFAULT_DHCP_RESYNC_ALL
#define OSYNC_HAL_USE_DEFAULT_INET_GET_IFACE_CONFIG
#define OSYNC_HAL_USE_DEFAULT_INET_SET_IFACE_CONFIG
#define OSYNC_HAL_USE_DEFAULT_INET_CREATE_GRE
#define OSYNC_HAL_USE_DEFAULT_INET_DESTROY_GRE
#define OSYNC_HAL_USE_DEFAULT_INET_ADD_TO_BRIDGE
#define OSYNC_HAL_USE_DEFAULT_INET_CREATE_VLAN
#define OSYNC_HAL_USE_DEFAULT_INIT
#define OSYNC_HAL_USE_DEFAULT_READY
#define OSYNC_HAL_USE_DEFAULT_DEINIT

#endif /* __OSYNC_HAL_CONFIG_H__ */
