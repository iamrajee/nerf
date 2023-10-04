apt update
apt install tasksel
tasksel install xfce-desktop

reboot

nvidia-xconfig #(optional)
apt-get install xrdp
echo xfce4-session > ~/.xsession
# vim /etc/xrdp/startwm.sh
# In the above file add the below line
# startxfce4
echo "startxfce4" >> /etc/xrdp/startwm.sh
systemctl restart xrdp
systemctl enable xrdp

iptables -A INPUT -p tcp --dport 3389 -j ACCEPT
netfilter-persistent save
netfilter-persistent reload
