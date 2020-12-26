#!/bin/sh

# Download and install vv
mkdir /tmp/vv
curl -L -H "Cache-Control: no-cache" -o /tmp/vv/vv.zip https://github.com/v2fly/v2ray-core/releases/latest/download/v2ray-linux-64.zip
unzip /tmp/vv/vv.zip -d /tmp/vv
install -m 755 /tmp/vv/v2ray /usr/local/bin/v2ray
install -m 755 /tmp/vv/v2ctl /usr/local/bin/v2ctl

# Remove temporary directory
rm -rf /tmp/vv

# vv new configuration
install -d /usr/local/etc/vv
cat << EOF > /usr/local/etc/vv/config.json
{
    "inbounds": [
        {
            "port": $PORT,
            "protocol": "vmess",
            "settings": {
                "clients": [
                    {
                        "id": "$UUID",
                        "alterId": 64
                    }
                ],
                "disableInsecureEncryption": true
            },
            "streamSettings": {
                "network": "ws"
            }
        }
    ],
    "outbounds": [
        {
            "protocol": "freedom"
        }
    ]
}
EOF

# Run vv
/usr/local/bin/v2ray -config /usr/local/etc/vv/config.json
