AUTHOR = 'Ibraar'
SITENAME = "Ibraar's Shayari"
SITEURL = '' # Set to your GitHub Pages URL in publishconf.py

PATH = 'content'
ARTICLE_PATHS = ['shayari'] # Look for Shayari posts here
PAGE_PATHS = ['pages'] # Look for static pages here
STATIC_PATHS = ['images', 'audio'] # Static files like images/audio

TIMEZONE = 'UTC' # Set your timezone

DEFAULT_LANG = 'en'

# Feed generation is usually not desired when developing
FEED_ALL_ATOM = None
CATEGORY_FEED_ATOM = None
TRANSLATION_FEED_ATOM = None
AUTHOR_FEED_ATOM = None
AUTHOR_FEED_RSS = None

# Social widget
SOCIAL = (('GitHub', 'https://github.com/vTheWise'), # Add your GitHub link
          # ('Another social link', '#'),
         )

DEFAULT_PAGINATION = 10

# Uncomment following line if you want document-relative URLs when developing
# RELATIVE_URLS = True

# --- Theme Settings ---
THEME = 'themes/shayari-theme'
# You can find themes at https://github.com/getpelican/pelican-themes

# --- Plugin Settings ---
PLUGIN_PATHS = ['plugins']
# Temporarily disabled until we fix the search plugin
# PLUGINS = ['tipue_search']

# --- Search Settings ---
DIRECT_TEMPLATES = ['index', 'tags', 'categories', 'authors', 'archives']

# --- Custom Settings for Poetry Cards ---
EXTRA_PATH_METADATA = {'extra/custom.css': {'path': 'theme/css/custom.css'}}
STATIC_PATHS = ['images', 'audio', 'extra/custom.css']

# --- Card Display Settings ---
CARD_COLUMNS = 3  # Number of columns for poetry cards on desktop

# --- Article URL and Save Path ---
# Controls where articles (Shayari posts) are saved and their URLs
ARTICLE_URL = 'shayari/{slug}.html'
ARTICLE_SAVE_AS = 'shayari/{slug}.html'

# --- Page URL and Save Path ---
# Controls where pages (like About) are saved and their URLs
PAGE_URL = 'pages/{slug}.html'
PAGE_SAVE_AS = 'pages/{slug}.html'

# --- Category/Tag URL and Save Path ---
CATEGORY_URL = 'category/{slug}.html'
CATEGORY_SAVE_AS = 'category/{slug}.html'
TAG_URL = 'tag/{slug}.html'
TAG_SAVE_AS = 'tag/{slug}.html'