"""
Tipue Search
============

A Pelican plugin to serialize generated HTML to JSON
that can be used by jQuery plugin - Tipue Search.

Copyright (c) Talha Mansoor
"""

from __future__ import unicode_literals

import os.path
import json
from bs4 import BeautifulSoup
from codecs import open
try:
    from urlparse import urljoin
except ImportError:
    from urllib.parse import urljoin

from pelican import signals


class Tipue_Search_JSON_Generator(object):

    def __init__(self, context, settings, path, theme, output_path, *args):
        self.output_path = output_path
        self.context = context
        self.siteurl = settings.get('SITEURL')
        self.tpages = settings.get('TEMPLATE_PAGES')
        self.output_path = output_path
        self.json_nodes = []

    def create_json_node(self, page):
        if getattr(page, 'status', 'published') != 'published':
            return

        soup_title = BeautifulSoup(page.title.replace('&nbsp;', ' '), 'html.parser')
        page_title = soup_title.get_text(' ', strip=True).replace('"', '"').replace('"', '"').replace(''', "'").replace('^', '&#94;')

        # Initialize page_text
        page_text = ''

        # Check if page has content attribute
        if hasattr(page, 'content'):
            soup_text = BeautifulSoup(page.content, 'html.parser')
            page_text = soup_text.get_text(' ', strip=True).replace('"', '"').replace('"', '"').replace(''', "'").replace('¶', ' ').replace('^', '&#94;')
            page_text = ' '.join(page_text.split())

        page_category = page.category.name if getattr(page, 'category', 'None') != 'None' else ''

        page_url = self.siteurl + '/' + page.url if self.siteurl else page.url

        node = {'title': page_title,
                'text': page_text,
                'tags': page_category,
                'url': page_url}

        self.json_nodes.append(node)

    def generate_output(self, writer):
        path = os.path.join(self.output_path, 'tipuesearch_content.json')

        pages = self.context['pages'] + self.context['articles']

        for article in self.context['articles']:
            pages += article.translations

        for page in pages:
            self.create_json_node(page)
        root_node = {'pages': self.json_nodes}

        with open(path, 'w', encoding='utf-8') as fd:
            json.dump(root_node, fd, separators=(',', ':'), ensure_ascii=False)


def get_generators(generators):
    return Tipue_Search_JSON_Generator


def register():
    signals.get_generators.connect(get_generators)
