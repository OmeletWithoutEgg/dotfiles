# ~/.config/qutebrowser/config.py
config.load_autoconfig()

c.auto_save.session = True
c.content.blocking.method = 'both'
c.content.javascript.can_access_clipboard = True
c.editor.command = ['konsole', '-e', 'vim', '{}'] 
c.fonts.default_size = '14pt'
c.fonts.web.family.fixed = 'Hack'
# c.new_instance_open_target = 'tab-silent'

c.url.default_page = 'https://google.com'
c.url.start_pages = 'https://codeforces.com'
c.url.searchengines = {
    'DEFAULT': 'https://duckduckgo.com/?q={}',
    'google': 'https://google.com/search?q={}',
    'translate': 'https://translate.google.com/?sl=auto&tl=en&&text={}',
    'archpkg': 'https://archlinux.org/packages/?q={}',
    'archwiki': 'https://wiki.archlinux.org/index.php?search={}',
    'aurpkg': 'https://aur.archlinux.org/packages?O=0&K={}',
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

## TODO
# - [ ] set dark mode to all sites except youtube?
# - [x] set a hotkey to auto focus on certain field and run qute-pass

config.unbind('ZQ')
config.unbind('co')
config.bind('ZC', 'close') # single hand `:q`
config.bind('<Alt-Esc>', 'fake-key <Esc>')
config.bind('<Alt-f>', 'fake-key f')
config.bind(';c', 'hint links spawn google-chrome-stable {hint-url}')
config.bind(';v', 'hint links spawn mpv {hint-url}')
# config.bind('cp', 'spawn google-chrome-stable {clipboard}')
config.bind('gs', 'greasemonkey-reload ;; later 500 reload --force')
config.bind('zb', 'hint inputs tab-bg --first \
        ;; later 1 spawn --userscript qute-pass -d "dmenu -fn Noto-16.0"')
config.bind('zm', 'spawn --userscript qute-pass --unfiltered -d "dmenu -fn Noto-16.0"')
config.bind('zp', 'spawn --userscript qute-pass --password-only')
config.bind('zu', 'spawn --userscript qute-pass --username-only')

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
