# ~/.config/qutebrowser/config.py
config.load_autoconfig()

c.auto_save.session = True
c.content.blocking.method = 'both'
c.content.javascript.can_access_clipboard = True
c.editor.command = ['konsole', '-e', 'vim', '{}'] 
c.fonts.default_size = '14pt'
c.fonts.web.family.fixed = 'Hack'
c.new_instance_open_target = 'tab-silent'
c.url.default_page = 'https://google.com'
c.url.start_pages = 'https://codeforces.com'
c.url.searchengines = {
    'DEFAULT': 'https://google.com/search?q={}',
    'archpkg': 'https://archlinux.org/packages/?q={}',
    'archwiki': 'https://wiki.archlinux.org/index.php?search={}'
}
c.zoom.default = '125%'

# c.content.headers.accept_language = 'en-US,en'
with config.pattern('*://*.wikipedia.org/**') as p:
    p.content.headers.accept_language = 'en-US,zh-TW,ja-JP,ja,en'

# config.set('colors.webpage.darkmode.enabled', True)
# config.set('colors.webpage.darkmode.enabled', False, '*://youtube.com/**')

## TODO
# - [ ] set dark mode to all sites except youtube?
# - [x] set a hotkey to auto focus on certain field and run qute-pass

config.unbind('ZQ')
config.bind('<Alt-Esc>', 'fake-key <Esc>')
config.bind(';v', 'hint links spawn mpv {hint-url}')
config.bind('gs', 'greasemonkey-reload ;; later 1 reload')
config.bind('zl', 'spawn --userscript qute-pass')
config.bind('zb', 'hint inputs tab-bg --first ;; later 1 spawn --userscript qute-pass') ## A little hacky: hint inputs tab-bg
config.bind('zm', 'spawn --userscript qute-pass --unfiltered -d "dmenu -fn Noto-16.0"')
# config.bind('zpl', 'spawn --userscript qute-pass --password-only')
# config.bind('zul', 'spawn --userscript qute-pass --username-only')

## YT blocking
### https://www.reddit.com/r/qutebrowser/comments/n6mcsa/did_anything_change_to_youtube_ads_not_blocked/
from qutebrowser.api import interceptor

def filter_yt(info: interceptor.Request):
	"""Block the given request if necessary."""
	url = info.request_url
	if (url.host() == 'www.youtube.com' and
			url.path() == '/get_video_info' and
			'&adformat=' in url.query()):
		info.block()

interceptor.register(filter_yt)

# config.source('qutebrowser-themes/themes/onedark.py')
# config.source('qutebrowser-themes/themes/gruvbox.py')
