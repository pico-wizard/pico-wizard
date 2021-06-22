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

"/etc/pico-wizard/"