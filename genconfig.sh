mkdir temp-conf
cd temp-conf
echo "entering temporary directory"
echo "getting config files from internet sources"
wget "https://gitlab.manjaro.org/manjaro-arm/packages/community/plamo-gear/pico-wizard-git/-/raw/master/pico-wizard.conf" 
wget "https://gitlab.manjaro.org/manjaro-arm/packages/community/plamo-gear/pico-wizard-git/-/raw/master/00-setup-autologin" "${pkgdir}/etc/pico-wizard/scripts.d/"
wget "https://gitlab.manjaro.org/manjaro-arm/packages/community/plamo-gear/pico-wizard-git/-/raw/master/finish.hook" "${pkgdir}/etc/pico-wizard/scripts.d/" 
wget "https://gitlab.manjaro.org/manjaro-arm/packages/community/plamo-gear/pico-wizard-git/-/raw/master/90-pico-wizard-autologin.conf" "${pkgdir}/etc/sddm.conf.d/"
wget "https://gitlab.manjaro.org/manjaro-arm/packages/community/plamo-gear/pico-wizard-git/-/raw/master/pico-wizard-session" "${pkgdir}/usr/bin/"
wget "https://gitlab.manjaro.org/manjaro-arm/packages/community/plamo-gear/pico-wizard-git/-/raw/master/pico-wizard-wrapper" "${pkgdir}/usr/bin/"
wget "https://gitlab.manjaro.org/manjaro-arm/packages/community/plamo-gear/pico-wizard-git/-/raw/master/pico-wizard-cleanup" "${pkgdir}/usr/bin/"
wget "https://gitlab.manjaro.org/manjaro-arm/packages/community/plamo-gear/pico-wizard-git/-/raw/master/pico-wizard-session.desktop" "${pkgdir}/usr/share/wayland-sessions/"
wget "https://gitlab.manjaro.org/manjaro-arm/packages/community/plamo-gear/pico-wizard-git/-/raw/master/pico-wizard-cleanup.service" "${pkgdir}/usr/lib/systemd/system/"
wget "https://raw.githubusercontent.com/pico-wizard/pico-wizard/main/files/polkit-1/rules.d/pico-wizard.rules"
wget "https://raw.githubusercontent.com/pico-wizard/pico-wizard/main/pico-wizard.svg" 
echo "copying config files to their target directory"
mv pico-wizard.conf/etc/pico-wizard/
mv 00-setup-autologin /etc/pico-wizard/scripts.d/
mv finish.hook /etc/pico-wizard/scripts.d/
mv 90-pico-wizard-autologin.conf /etc/sddm.conf.d/
mv pico-wizard-session /usr/bin/
mv pico-wizard-wrapper /usr/bin/
mv pico-wizard-cleanup /usr/bin/
mv pico-wizard-session.desktop /usr/share/wayland-sessions/
mv pico-wizard-cleanup.service /usr/lib/systemd/system/
mv pico-wizard.svg /usr/share/icons/hicolor/scalable/apps/
mv pico-wizard.rules /usr/share/polkit-1/rules.d/
