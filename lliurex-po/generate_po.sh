#!/bin/bash

cp ../install-files/usr/sbin/lliurex-news-setup /tmp/lliurex-news.py

xgettext ../install-files/usr/share/lliurex-news/rsrc/lliurex-news-setup.glade /tmp/lliurex-news.py -o lliurex-news/lliurex-news.pot

