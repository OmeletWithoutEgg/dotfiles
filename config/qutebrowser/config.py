# ~/.config/qutebrowser/config.py
import urllib
import os


def dummy(): global c, config  # disable pyflakes error


config.load_autoconfig()

c.qt.args = [
    # 'use-gl=desktop',
    'ignore-gpu-blocklist',
    'enable-gpu-rasterization',
    # 'enable-unsafe-webgpu',
    'enable-native-gpu-memory-buffers',
    'enable-zero-copy',
    # 'num-raster-threads=4',
    # 'enable-accelerated-video-decode',
    # 'disable-accelerated-2d-canvas',
    # 'ozone-platform=wayland',
]
c.qt.workarounds.disable_accelerated_2d_canvas = 'never'

c.auto_save.session = True
c.content.blocking.method = 'both'
c.content.javascript.clipboard = 'access'
c.editor.command = ['wezterm', 'start', '--', 'nvim', '{}']
c.fonts.default_size = '16pt'
c.fonts.default_family = 'Source Code Pro Semi Bold'
c.fonts.web.family.fixed = 'Hack'

c.window.hide_decoration = True
# c.new_instance_open_target = 'tab-silent'

c.url.default_page = 'qute://start'
c.url.start_pages = 'https://mail.google.com'

# c.fileselect.handler = 'external'
# c.fileselect.folder.command = [
#     'wezterm', 'start', '--', 'ranger', '--choosedir={}',
#     '--cmd=set global_inode_type_filter d']
# c.fileselect.single_file.command = [
#     'wezterm', 'start', '--', 'ranger', '--choosefile={}']
# c.fileselect.multiple_files.command = [
#     'wezterm', 'start', '--', 'ranger', '--choosefiles={}']


def make_sites_query(sites):
    query = '(' + ' OR '.join([f'site:{site}' for site in sites]) + ')'
    return urllib.parse.quote_plus(query)


c.url.searchengines = {
    # TODO nitter
    'DEFAULT':  'https://duckduckgo.com/?q={}',
    'g':   'https://google.com/search?q={}',
    # 'searchyt': 'https://youtu.be/results?search_query={}',
    'toen':     'https://translate.google.com/?sl=auto&tl=en&&text={}',
    'tozh':     'https://translate.google.com/?sl=auto&tl=zh-tw&&text={}',
    'archwiki': 'https://wiki.archlinux.org/index.php?search={}',
    'archpkg':  'https://archlinux.org/packages/?q={}',
    'aurpkg':   'https://aur.archlinux.org/packages?O=0&K={}',
    'pkg':
        'https://duckduckgo.com/?q={}%20' + make_sites_query([
            'repology.org',
            'pkgs.org',
            'aur.archlinux.org',
            'archlinux.org/packages',
            'hub.docker.com',
            'pypi.org',
        ]),
}

c.zoom.default = '125%'
c.colors.webpage.preferred_color_scheme = 'dark'
# c.content.headers.accept_language = 'en-US,en'

with config.pattern('*://*.wikipedia.org/**') as p:
    p.content.headers.accept_language = 'en-US,zh-TW,ja-JP,ja,en'
with config.pattern('*://ani.gamer.com.tw/**') as p:
    p.content.blocking.enabled = False

# config.set('colors.webpage.darkmode.enabled', True)
# config.set('colors.webpage.darkmode.enabled', False, '*://youtube.com/**')

# TODO
# - [ ] set dark mode to all sites except youtube?
# - [x] set a hotkey to auto focus on certain field and run qute-pass

config.unbind('ZQ')
config.unbind('co')
config.unbind('sf')
config.unbind('sk')
config.unbind('sl')
config.unbind('ss')

config.bind('ZC', 'close')  # single hand `:q`
config.bind('<Alt-Esc>', 'fake-key <Esc>')
config.bind('<Alt-f>', 'fake-key f')
config.bind('<Alt-9>', 'tab-focus -1')

config.bind('<Alt-.>', 'fake-key <Shift-.>')  # speed up
config.bind('<Alt-,>', 'fake-key <Shift-,>')  # speed down

chrome = 'google-chrome-stable --profile-directory=Default'
config.bind('cc', f'spawn --detach {chrome} {{url}}')
config.bind(';c', f'hint links spawn --detach {chrome} {{hint-url}}')
# config.bind('cp', 'spawn google-chrome-stable {clipboard}')

config.bind(';v', 'hint links spawn --detach mpv {hint-url} --slang="tw,en"')
config.bind('yg', 'spawn --userscript yank-url-path')

config.bind('gs', 'greasemonkey-reload ;; cmd-later 500 reload --force')
config.bind('ge', 'edit-url')
config.bind('gyd', 'spawn --userscript dl_audio')
config.bind('ce', 'config-edit')

if os.environ['XDG_SESSION_TYPE'] == "wayland":
    pass_menu = 'wofi --dmenu'
else:
    pass_menu = 'rofi -dmenu'
qute_pass = f'spawn --userscript qute-pass -d "{pass_menu}"'

config.bind('<Ctrl-Shift-l>', f'{qute_pass}', mode='insert')
config.bind('zb', f'hint inputs tab-bg --first ;; cmd-later 1 {qute_pass}')
config.bind('zm', f'{qute_pass} --unfiltered')
config.bind('zp', f'{qute_pass} --password-only')
config.bind('zu', f'{qute_pass} --username-only')
config.bind('zo', f'{qute_pass} --otp-only')

hint_chars = {
    'DEFAULT': 'asdfghjkl',
    'left': 'zxcv' + 'qwer' + 'asdf',
    'right': 'uiophjklbnm',
}
c.hints.chars = hint_chars["DEFAULT"]
config.unbind('ga')
config.bind('gaa', f'set hints.chars {hint_chars["left"]}')
config.bind('gll', f'set hints.chars {hint_chars["right"]}')
config.bind('ghh', f'set hints.chars {hint_chars["DEFAULT"]}')

# config.source('qutebrowser-themes/themes/onedark.py')
# config.source('qutebrowser-themes/themes/gruvbox.py')
# config.source('/home/omelet/Downloads/qb-breath.py')

ublockOrigin = 'https://github.com/uBlockOrigin/uAssets/raw/master/filters'

c.content.blocking.adblock.lists = [
    "https://easylist.to/easylist/easylist.txt",
    "https://easylist.to/easylist/easyprivacy.txt",
    "https://secure.fanboy.co.nz/fanboy-cookiemonster.txt",
    "https://easylist.to/easylist/fanboy-annoyance.txt",
    "https://secure.fanboy.co.nz/fanboy-annoyance.txt",
    f"{ublockOrigin}/annoyances.txt",
    f"{ublockOrigin}/filters-2020.txt",
    f"{ublockOrigin}/unbreak.txt",
    f"{ublockOrigin}/resource-abuse.txt",
    f"{ublockOrigin}/privacy.txt",
    f"{ublockOrigin}/filters.txt"
]
