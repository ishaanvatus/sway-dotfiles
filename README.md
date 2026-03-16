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

### Librewolf
- Turn off history deletion
- Plugins: [Vimium](https://vimium.github.io/), [TWP](https://github.com/FilipePS/Traduzir-paginas-web), [Dark Reader](https://github.com/darkreader/darkreader), [TamperMonkey](https://www.tampermonkey.net/)

### Chromium
- Plugins: Vimium and Ublock Lite
- Install Web Whatsapp and cstimer

### Forgetful
- qt5ct dark theme, qt6ct dark theme, lxappearance dark theme
- Signal login
- Thunderbird login
- GitHub login
