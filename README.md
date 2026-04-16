# Post Install 
## /etc/sudoers
```
# specify the timeout type (usual default=tty)
Defaults:savantshuia timestamp_type=global

# specify the timeout interval (usual default=15)
Defaults:savantshuia timestamp_timeout=5
```
## [searxng docker install](https://docs.searxng.org/admin/installation-docker.html)
```
mkdir -p ~/.searxng/config/ ~/.searxng/data/
cd ~/.searxng/
docker run --name searxng -d \
    -p 8888:8080 --restart always \
    -v "./config/:/etc/searxng/" \
    -v "./data/:/var/cache/searxng/" \
    docker.io/searxng/searxng:latest
```
## Apps left to install
- [Anki](https://apps.ankiweb.net/#downloads), [instructions](https://docs.ankiweb.net/platform/linux/installing.html)
- [MakeMKV](https://forum.makemkv.com/forum/viewtopic.php?f=3&t=224)
- [nsxiv](https://codeberg.org/nsxiv/nsxiv)
- [TeX Live](https://www.tug.org/texlive/quickinstall.html)
- [Vial](https://get.vial.today/download/), make a Vial.desktop in ~/.local/share/applications
- [Strawberry Spotify Plugin](https://wiki.strawberrymusicplayer.org/wiki/Installing_GStreamer_Spotify_plugin)
- [Neovim](https://neovim.io/doc/install/#install-from-source)

### Librewolf
- Extensions
    - [Vimium](https://vimium.github.io/)
    - [TWP](https://github.com/FilipePS/Traduzir-paginas-web)
    - [Dark Reader](https://github.com/darkreader/darkreader) 
    - [TamperMonkey](https://www.tampermonkey.net/)
- Turn off history deletion
- Startup Behaviour
- Download Behaviour

### Chromium
- Extensions
    - [uBlock Origin Lite](https://chromewebstore.google.com/detail/ublock-origin-lite/ddkjiahejlhfcafbddmgiahcphecmpfh?hl=en)
    - nothing else, [avoid using chromium](https://fractionalciso.com/the-secret-web-browser-monopoly/)
- Startup Behaviour
- Download Behaviour

### Dark Theme
- qt5ct dark theme & qt6ct dark theme: darker
- lxappearance dark theme: Adwaita Dark
- librewolf, anki, calibre, chromium, thunderbird, foliate

### Email and Messaging
- Thunderbird 
- Signal
- Whatsapp Web
