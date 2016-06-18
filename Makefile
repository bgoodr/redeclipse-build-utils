ifeq "$(BRANCH)" ""
  $(error BRANCH must be specified: BRANCH=stable make)
endif

BASE = redeclipse-git-$(BRANCH)

.PHONY: all
all : build

.PHONY: build
build : update packages
	cd $(BASE); REDECLIPSE_BRANCH="source" ./redeclipse.sh

.PHONY: update
update : $(BASE)
	cd $(BASE); git checkout $(BRANCH)
	cd $(BASE); git pull
	cd $(BASE); git submodule update
	if [ -d $(HOME)/.redeclipse -a ! -d $(BASE)/home ]; then \
		cp -rp $(HOME)/.redeclipse $(BASE)/home; \
	fi

$(BASE) :
	git clone --recursive https://github.com/red-eclipse/base.git $(BASE)

# The different branches use different packages:
sdl_config_package_stable = libsdl1.2-dev
sdl_config_package_master = libsdl2-dev

sdl_mixer_package_stable = libsdl-mixer1.2-dev
sdl_mixer_package_master = libsdl2-mixer-dev

sdl_image_package_stable = libsdl-image1.2-dev
sdl_image_package_master = libsdl2-image-dev

.PHONY: packages
packages :
	sudo apt-get -y install git build-essential $(sdl_mixer_package_$(BRANCH)) $(sdl_image_package_$(BRANCH)) $(sdl_config_package_$(BRANCH))
