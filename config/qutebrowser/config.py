# ~/.config/qutebrowser/config.py
config.load_autoconfig()

c.auto_save.session = True
c.content.blocking.method = 'both'
c.content.javascript.can_access_clipboard = True
c.editor.command = ['wezterm', 'start', '--', 'nvim', '{}'] 
c.fonts.default_size = '20pt'
c.fonts.default_family = 'Source Code Pro Semi Bold'
c.fonts.web.family.fixed = 'Hack'

c.window.hide_decoration = True
# c.new_instance_open_target = 'tab-silent'

c.url.default_page = 'https://google.com'
c.url.start_pages = 'https://codeforces.com'
c.url.searchengines = {
    'DEFAULT': 'https://duckduckgo.com/?q={}',
    'google': 'https://google.com/search?q={}',
    'toen': 'https://translate.google.com/?sl=auto&tl=en&&text={}',
    'tozh': 'https://translate.google.com/?sl=auto&tl=zh-tw&&text={}',
    'archpkg': 'https://archlinux.org/packages/?q={}',
    'archwiki': 'https://wiki.archlinux.org/index.php?search={}',
    'aurpkg': 'https://aur.archlinux.org/packages?O=0&K={}',
}

c.zoom.default = '200%'
c.colors.webpage.preferred_color_scheme = 'dark'
# c.content.headers.accept_language = 'en-US,en'

with config.pattern('*://*.wikipedia.org/**') as p:
    p.content.headers.accept_language = 'en-US,zh-TW,ja-JP,ja,en'
with config.pattern('*://ani.gamer.com.tw/**') as p:
    p.content.blocking.enabled = False

# config.set('colors.webpage.darkmode.enabled', True)
# config.set('colors.webpage.darkmode.enabled', False, '*://youtube.com/**')

## TODO
# - [ ] set dark mode to all sites except youtube?
# - [x] set a hotkey to auto focus on certain field and run qute-pass

config.unbind('ZQ')
config.unbind('co')
config.unbind('sf')
config.unbind('sk')
config.unbind('sl')
config.unbind('ss')

config.bind('ZC', 'close') # single hand `:q`
config.bind('<Alt-Esc>', 'fake-key <Esc>')
config.bind('<Alt-f>', 'fake-key f')
config.bind('cc', 'spawn --detach google-chrome-stable {url}')
config.bind(';c', 'hint links spawn --detach google-chrome-stable {hint-url}')
config.bind(';v', 'hint links spawn --detach mpv {hint-url}')
config.bind('yg', 'spawn --userscript yank-url-path')
# config.bind('cp', 'spawn google-chrome-stable {clipboard}')
config.bind('gs', 'greasemonkey-reload ;; later 500 reload --force')

pass_menu = 'rofi -dmenu -theme ~/.config/rofi/theme.rasi'
config.bind('<Ctrl-Shift-l>', 'spawn --userscript qute-pass  -d "{pass_menu}"', mode='insert')
config.bind('zb', f'hint inputs tab-bg --first \
        ;; later 1 spawn --userscript qute-pass  -d "{pass_menu}"')
config.bind('zm', f'spawn --userscript qute-pass -d "{pass_menu}" --unfiltered')
config.bind('zp', f'spawn --userscript qute-pass -d "{pass_menu}" --password-only')
config.bind('zu', f'spawn --userscript qute-pass -d "{pass_menu}" --username-only')

hint_chars = {
    'DEFAULT': 'asdfghjkl',
    'left': 'qwerasdfzxcv',
    'right': 'uiophjklbnm',
}
c.hints.chars = hint_chars["DEFAULT"]
config.bind('ga', f'set hints.chars {hint_chars["left"]}')
config.bind('gl', f'set hints.chars {hint_chars["right"]}')
config.bind('gh', f'set hints.chars {hint_chars["DEFAULT"]}')

# config.source('qutebrowser-themes/themes/onedark.py')
# config.source('qutebrowser-themes/themes/gruvbox.py')
