#!/bin/bash

cp ../lliurex-news-setup/usr/sbin/lliurex-news-setup /tmp/lliurex-news.py

xgettext ../lliurex-news-setup/usr/share/lliurex-news-setup/rsrc/lliurex-news-setup.ui /tmp/lliurex-news.py -o lliurex-news-setup/lliurex-news-setup.pot

