cp -f /vagrant/provision/.bash_profile /home/vagrant/.bash_profile
cp -f /vagrant/provision/.bashrc /home/vagrant/.bashrc
if [ -x /usr/bin/Xvfb ] && [ -x /usr/bin/VBoxClient ] && [ ! -f /tmp/.X0-lock ]; then
    Xvfb -screen 0 320x240x8 > /dev/null 2>&1 &
    sleep 0.5
    DISPLAY=:0 VBoxClient --clipboard
fi
