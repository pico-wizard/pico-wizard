#!/bin/bash

# SPDX-FileCopyrightText: 2021 Aditya Mehra <aix.m@outlook.com>
#
# SPDX-License-Identifier: MIT

SCRIPTFILE=/etc/pico-wizard/scripts.d/01-fix-mycroft-perms

if [[ -f "$SCRIPTFILE" ]]; then
    echo "$SCRIPTFILE exist skipping"
else
    mkdir -p /etc/pico-wizard/scripts.d/
    printf "#! /bin/bash\n\nchown -R \$PICOWIZARD_USERNAME:\$PICOWIZARD_USERNAME /opt/mycroft-core/\nchown -R \$PICOWIZARD_USERNAME:\$PICOWIZARD_USERNAME /opt/mycroft/" >> /etc/pico-wizard/scripts.d/01-fix-mycroft-perms
    chmod 755 /etc/pico-wizard/scripts.d/01-fix-mycroft-perms
fi

rm /etc/xdg/bigscreen
printf "[General]\nMycroftEnabled=true\n" >> /etc/xdg/bigscreen
