PY = python
PELICAN = pelican
PELICANOPTS =

BASEDIR = $(CURDIR)
INPUTDIR = $(BASEDIR)/content
OUTPUTDIR = $(BASEDIR)/output
CONFFILE = $(BASEDIR)/pelicanconf.py
PUBLISHCONF = $(BASEDIR)/publishconf.py

FTP_HOST = localhost
FTP_USER = anonymous
FTP_TARGET_DIR = /

SSH_HOST = localhost
SSH_PORT = 22
SSH_USER = root
SSH_TARGET_DIR = /var/www

S3_BUCKET = my_s3_bucket

CLOUDFILES_USERNAME = my_rackspace_username
CLOUDFILES_API_KEY = my_rackspace_api_key
CLOUDFILES_CONTAINER = my_cloudfiles_container

DROPBOX_DIR = /

GITHUB_PAGES_BRANCH = gh-pages

DEBUG ?= 0
ifeq ($(DEBUG), 1)
    PELICANOPTS += -D
endif

RELATIVE ?= 0
ifeq ($(RELATIVE), 1)
    PELICANOPTS += --relative-urls
endif

help:
	@echo "Makefile for a Pelican website"
	@echo
	@echo "Usage:"
	@echo "   make html                           (re)generate the web site"
	@echo "   make clean                          remove the generated files"
	@echo "   make regenerate                     regenerate files upon modification"
	@echo "   make publish                        generate using production settings"
	@echo "   make serve [PORT=8000]              serve site at http://localhost:8000"
	@echo "   make serve-global [PORT=8000]       serve site on all network interfaces at http://0.0.0.0:8000"
	@echo "   make devserver [PORT=8000]          start/restart develop_server.sh script"
	@echo "   make stopserver                     stop local server"
	@echo "   make ssh_upload                     upload the web site via SSH"
	@echo "   make rsync_upload                   upload the web site via rsync+ssh"
	@echo "   make dropbox_upload                 upload the web site via Dropbox"
	@echo "   make ftp_upload                     upload the web site via FTP"
	@echo "   make s3_upload                      upload the web site via S3"
	@echo "   make cf_upload                      upload the web site via Rackspace Cloud Files"
	@echo "   make github                         upload the web site via gh-pages"
	@echo
	@echo "Set the DEBUG variable to 1 to enable debug messages"
	@echo "Set the RELATIVE variable to 1 to enable relative urls"
	@echo

html:
	$(PELICAN) $(INPUTDIR) -o $(OUTPUTDIR) -s $(CONFFILE) $(PELICANOPTS)

clean:
	[ ! -d $(OUTPUTDIR) ] || rm -rf $(OUTPUTDIR)

regenerate:
	$(PELICAN) -r $(INPUTDIR) -o $(OUTPUTDIR) -s $(CONFFILE) $(PELICANOPTS)

publish:
	$(PELICAN) $(INPUTDIR) -o $(OUTPUTDIR) -s $(PUBLISHCONF) $(PELICANOPTS)

serve:
	$(PELICAN) -lr $(INPUTDIR) -o $(OUTPUTDIR) -s $(CONFFILE) $(PELICANOPTS) &
	cd $(OUTPUTDIR) && $(PY) -m http.server 8000

serve-global:
	$(PELICAN) -lr $(INPUTDIR) -o $(OUTPUTDIR) -s $(CONFFILE) $(PELICANOPTS) & \\
	cd $(OUTPUTDIR) && $(PY) -m http.server $(PORT) --bind 0.0.0.0

devserver:
	$(PELICAN) -lr $(INPUTDIR) -o $(OUTPUTDIR) -s $(CONFFILE) $(PELICANOPTS) &
	cd $(OUTPUTDIR) && $(PY) -m http.server 8000

stopserver:
	kill -9 `ps aux | grep '[p]elican.server' | awk '{print $$2}'`
	kill -9 `ps aux | grep '[h]ttp.server' | awk '{print $$2}'`

ssh_upload: publish
	scp -P $(SSH_PORT) -r $(OUTPUTDIR)/* $(SSH_USER)@$(SSH_HOST):$(SSH_TARGET_DIR)

rsync_upload: publish
	rsync -e "ssh -p $(SSH_PORT)" -P -rvzc --delete $(OUTPUTDIR)/ $(SSH_USER)@$(SSH_HOST):$(SSH_TARGET_DIR) --cvs-exclude

dropbox_upload: publish
	cp -r $(OUTPUTDIR)/* $(DROPBOX_DIR)

ftp_upload: publish
	lftp ftp://$(FTP_USER)@$(FTP_HOST) -e "mirror -R $(OUTPUTDIR) $(FTP_TARGET_DIR) ; quit"

s3_upload: publish
	s3cmd sync $(OUTPUTDIR)/ s3://$(S3_BUCKET)/ --delete-removed -P

cf_upload: publish
	cd $(OUTPUTDIR) && swift -v -A https://auth.api.rackspacecloud.com/v1.0 -U $(CLOUDFILES_USERNAME) -K $(CLOUDFILES_API_KEY) upload -c $(CLOUDFILES_CONTAINER) .

# Requires gh-pages branch to be setup first:
# git checkout -b gh-pages
# git push origin gh-pages --set-upstream
# git checkout master
github: publish
	ghp-import $(OUTPUTDIR) -b $(GITHUB_PAGES_BRANCH)
	git push origin $(GITHUB_PAGES_BRANCH)

.PHONY: html help clean regenerate publish serve serve-global devserver stopserver ssh_upload rsync_upload dropbox_upload ftp_upload s3_upload cf_upload github