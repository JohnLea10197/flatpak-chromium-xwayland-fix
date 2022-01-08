#!/bin/sh

if [ "$XDG_SESSION_TYPE" = 'wayland' ]; then
    /usr/bin/flatpak run --branch=stable --arch=x86_64 --command=/app/bin/chromium --file-forwarding org.chromium.Chromium -enable-features=useozoneplatform --ozone-platform=wayland --incognito
else
    /usr/bin/flatpak run --branch=stable --arch=x86_64 --command=/app/bin/chromium --file-forwarding org.chromium.Chromium --icognito
fi
