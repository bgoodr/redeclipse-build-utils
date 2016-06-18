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

$(BASE) :
	git clone --recursive https://github.com/red-eclipse/base.git $(BASE)

# The stable branch uses sdl-config while master branch uses sdl2-config,
# so get the correct package based upon the branch used:
sdl_config_package_stable = libsdl1.2-dev
sdl_config_package_master = libsdl2-dev

# Ditto for SDL_mixer.h :
sdl_mixer_package_stable = libsdl-mixer1.2-dev
sdl_mixer_package_master = libsdl2-mixer-dev

.PHONY: packages
packages :
	sudo apt-get -y install git build-essential $(sdl_mixer_package_$(BRANCH)) libsdl2-image-dev $(sdl_config_package_$(BRANCH))
