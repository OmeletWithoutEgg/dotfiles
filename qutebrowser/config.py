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

config.unbind('ZQ')
config.bind(';v', 'hint links spawn mpv {hint-url}')
config.bind('<Alt-Esc>', 'fake-key <Esc>')
config.bind('<Ctrl-Alt-P>', 'spawn --userscript qute-pass', 'insert')
config.bind('gs', 'greasemonkey-reload ;; reload')
config.bind('zl', 'spawn --userscript qute-pass')
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
