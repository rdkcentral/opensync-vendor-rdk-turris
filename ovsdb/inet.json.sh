if [ "$CONFIG_RDK_EXTENDER" == "y" ]; then
    # do nothing if not set
    echo '["Open_vSwitch"]'
    exit
fi

cat << EOF
[
    "Open_vSwitch",
    {
        "op":"insert",
        "table":"Wifi_Inet_Config",
        "row": {
            "if_name": "brlan0",
            "ip_assign_scheme": "static",
            "if_type": "bridge",
            "inet_addr": "10.0.0.1",
            "netmask": "255.255.255.0",
            "dhcpd":  ["map",[
                              ["dhcp_option","26, 1600"],
                              ["force","false"],
                              ["lease_time", "12h"],
                              ["start", "10.0.0.2"],
                              ["stop", "10.0.0.253"]
                      ]],
            "network": true,
            "enabled": true
       }
    },
    {
        "op":"insert",
        "table":"Wifi_Inet_Config",
        "row": {
            "if_name": "erouter0",
            "if_type": "vif",
            "enabled": false
       }
    },
    {
        "op":"insert",
        "table":"Wifi_Inet_Config",
        "row": {
            "if_name": "wifi2",
            "ip_assign_scheme": "static",
            "if_type": "vif",
            "mtu": 1600,
            "inet_addr": "169.254.0.1",
            "netmask":"255.255.255.128",
            "dhcpd":  ["map",[
                              ["dhcp_option","26, 1600"],
                              ["force","false"],
                              ["lease_time", "12h"],
                              ["start", "169.254.0.10"],
                              ["stop", "169.254.0.126"]
                      ]],
            "network": true,
            "enabled": true
       }
    },
    {
        "op":"insert",
        "table":"Wifi_Inet_Config",
        "row": {
            "if_name": "wifi3",
            "ip_assign_scheme": "static",
            "if_type": "vif",
            "mtu": 1600,
            "inet_addr": "169.254.1.1",
            "netmask":"255.255.255.128",
            "dhcpd":  ["map",[
                              ["dhcp_option","26, 1600"],
                              ["force","false"],
                              ["lease_time", "12h"],
                              ["start", "169.254.1.10"],
                              ["stop", "169.254.1.126"]
                      ]],
            "network": true,
            "enabled": true
       }
    },
    {
        "op":"insert",
        "table":"Wifi_Inet_Config",
        "row": {
            "if_name": "wifi6",
            "ip_assign_scheme": "static",
            "if_type": "vif",
            "mtu": 1600,
            "inet_addr": "169.254.0.129",
            "netmask":"255.255.255.128",
            "dhcpd":  ["map",[
                              ["dhcp_option","26, 1600"],
                              ["force","false"],
                              ["lease_time", "12h"],
                              ["start", "169.254.0.130"],
                              ["stop", "169.254.0.254"]
                      ]],
            "network": true,
            "enabled": true
       }
    },
    {
        "op":"insert",
        "table":"Wifi_Inet_Config",
        "row": {
            "if_name": "wifi7",
            "ip_assign_scheme": "static",
            "if_type": "vif",
            "mtu": 1600,
            "inet_addr": "169.254.1.129",
            "netmask":"255.255.255.128",
            "dhcpd":  ["map",[
                              ["dhcp_option","26, 1600"],
                              ["force","false"],
                              ["lease_time", "12h"],
                              ["start", "169.254.1.130"],
                              ["stop", "169.254.1.252"]
                      ]],
            "network": true,
            "enabled": true
       }
    }

]
EOF
