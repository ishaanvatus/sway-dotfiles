# How to use this repo
- Firstly: free free to report any issues, I'll get around to it if I can replicate it.
- This scripts sets up a full [Sway](https://swaywm.org/) desktop experience configured to my personal usage, pls try it out.
- Get the [Fedora Linux](https://fedoraproject.org/) [Everything](https://fedoraproject.org/misc/#everything) ISO (netinstaller)
- Use the partition scheme given in [PARTITION_SCHEME.md](./PARTITION_SCHEME.md)
- Under "Software Selection"
    - Under "Base Environment" pick "Fedora Custom Operating System" 
    - Under "Add-Ons for Selected Environment" pick Standard, C Development Tools and Libraries & Development Tools
- [Disable root](https://wiki.archlinux.org/title/Sudo#Disable_root_login)
- Finish the rest of the steps in the installer and boot into your system, you will mostly likely need ethernet or usb-tethering
- The wifi drivers included are iwlwifi-mvm-firmware, graphics drivers for intel integrated, adapt the PKGS in bootstrap.sh
```
git clone https://github.com/ishaanvatus/dotfiles .dotfiles
cd .dotfiles
bash bootstrap.sh
## the script will ask for sudo a couple of times
## installer options for rustup and deno, just follow the echoed instructions (don't add anything to path and don't add any completions)
```

## Post Install 
### /etc/sudoers (replace "john" with your username)
```
# specify the timeout type (usual default=tty)
Defaults:john timestamp_type=global

# specify the timeout interval (usual default=15)
Defaults:john timestamp_timeout=5
```
### [searxng docker install](https://docs.searxng.org/admin/installation-docker.html)
```
mkdir -p ~/.searxng/config/ ~/.searxng/data/
```
```
cd ~/.searxng/
```
```
docker run --name searxng -d \
    -p 8888:8080 --restart always \
    --dns 9.9.9.9 --dns 149.112.112.112 \
    -v "./config/:/etc/searxng/" \
    -v "./data/:/var/cache/searxng/" \
    docker.io/searxng/searxng:latest
```
- http://localhost:8888/search?q=%s
### Apps left to install
- [wl-clipboard](https://github.com/bugaevc/wl-clipboard/blob/master/BUILDING.md)
    - due to the upstream not including the feature from this [keepassxc issue](https://github.com/keepassxreboot/keepassxc/discussions/10704#discussioncomment-14200858), smh 🫩
- [Neovim](https://neovim.io/doc/install/#install-from-source)
- [nsxiv](https://codeberg.org/nsxiv/nsxiv)
- [TeX Live](https://www.tug.org/texlive/quickinstall.html)
    ```
    curl -L -o install-tl-unx.tar.gz https://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
    zcat < install-tl-unx.tar.gz | tar xf -
    cd install-tl-2*
    sudo perl ./install-tl --no-interaction
    ```
- [Vial](https://get.vial.today/download/), make a Vial.desktop in ~/.local/share/applications
- [Strawberry Spotify Plugin](https://wiki.strawberrymusicplayer.org/wiki/Installing_GStreamer_Spotify_plugin)
- [Anki](https://apps.ankiweb.net/#downloads), [instructions](https://docs.ankiweb.net/platform/linux/installing.html)
- [MakeMKV](https://forum.makemkv.com/forum/viewtopic.php?f=3&t=224), [Beta Key](https://forum.makemkv.com/forum/viewtopic.php?t=1053)
- [Ranger](https://github.com/ranger/ranger#installing-from-a-clone), still using ranger since lf is not fully configured like ranger yet

### Librewolf
- Extensions
    - [Vimium](https://vimium.github.io/)
    - [Dark Reader](https://github.com/darkreader/darkreader) 
    - [TWP](https://github.com/FilipePS/Traduzir-paginas-web)
    - [TamperMonkey](https://www.tampermonkey.net/)
- Turn off history deletion
- Startup Behaviour
- Download Behaviour

### Chromium
- Extensions
    - [uBlock Origin Lite](https://chromewebstore.google.com/detail/ublock-origin-lite/ddkjiahejlhfcafbddmgiahcphecmpfh?hl=en)
- Startup Behaviour
- Download Behaviour
- Whatsapp Web

### Dark Theme
- qt5ct dark theme & qt6ct dark theme: darker
- lxappearance dark theme: Adwaita Dark
- librewolf, anki, calibre, chromium, thunderbird, foliate

### MISC
- logseq maybe (flatpak)
- /etc/libvirt/network.conf: change 
    ```
    #firewall_backend = "nftables"
    firewall_backend = "iptables"
    ```
