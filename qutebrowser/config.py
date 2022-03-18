# ~/.config/qutebrowser/config.py

config.unbind('ZQ')

config.bind('zl', 'spawn --userscript qute-pass')
config.bind('zul', 'spawn --userscript qute-pass --username-only')
config.bind('zpl', 'spawn --userscript qute-pass --password-only')

c.editor.command = ['konsole', '-e', 'vim', '{}'] 

c.url.default_page = 'https://google.com'
c.url.start_pages = 'https://codeforces.com'
c.url.searchengines = {'DEFAULT': 'https://google.com/search?q={}'}

c.zoom.default = '125%'
c.fonts.default_size = '14pt'
c.fonts.web.family.fixed = 'Hack'

c.content.blocking.method = 'both'

c.auto_save.session = True

c.content.javascript.can_access_clipboard = True

c.new_instance_open_target = 'tab-silent'

# from qutebrowser.api import interceptor
# 
# def filter_yt(info: interceptor.Request):
# 	"""Block the given request if necessary."""
# 	url = info.request_url
# 	if (url.host() == 'www.youtube.com' and
# 			url.path() == '/get_video_info' and
# 			'&adformat=' in url.query()):
# 		info.block()
# 
# interceptor.register(filter_yt)

config.load_autoconfig()
