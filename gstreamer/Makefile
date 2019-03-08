gstVersion := 1.15.1
installDir := $(HOME)/.programs/gst$(gstVersion)
down:
	wget https://gstreamer.freedesktop.org/src/gstreamer/gstreamer-$(gstVersion).tar.xz
	wget https://gstreamer.freedesktop.org/src/gst-plugins-base/gst-plugins-base-$(gstVersion).tar.xz
	wget https://gstreamer.freedesktop.org/src/gst-plugins-good/gst-plugins-good-$(gstVersion).tar.xz
	wget https://gstreamer.freedesktop.org/src/gst-plugins-bad/gst-plugins-bad-$(gstVersion).tar.xz
	wget https://gstreamer.freedesktop.org/src/gst-plugins-ugly/gst-plugins-ugly-$(gstVersion).tar.xz

extract:
	$(call rm_and_extract_files, $(modules))
	$(call init_gits, $(modules))

patch:
	cd gstreamer-$(gstVersion) && git apply ../gst_src.diff
	cd gst-plugins-good-$(gstVersion) && git apply ../good_src.diff
	cd gst-plugins-bad-$(gstVersion) && git apply ../bad_src.diff

config_and_make:
	$(call config_n_make_modules, $(modules))

reinstall:
	cd gstreamer-$(gstVersion) && make install -j4
	cd gst-plugins-base-$(gstVersion) && make install -j4
	cd gst-plugins-good-$(gstVersion) && make install -j4
	cd gst-plugins-bad-$(gstVersion) && make install -j4
	cd gst-plugins-ugly-$(gstVersion) && make install -j4

modules := \
	gstreamer-$(gstVersion) \
	gst-plugins-base-$(gstVersion) \
	gst-plugins-good-$(gstVersion) \
	gst-plugins-bad-$(gstVersion) \
	gst-plugins-ugly-$(gstVersion)

t:
	$(call rm_and_extract_files)

define init_git 
	cd $1 && git init && git add . &&  git commit -m "initial";

endef

define init_gits
$(foreach var, $1,$(call init_git, $(var)))
endef

define rm_and_extract_file
	rm -fr $1
	tar xaf $1.tar.xz

endef

define rm_and_extract_files
$(foreach var, $1,$(call rm_and_extract_file, $(var)))
endef

define config_n_make
	cd $1 && ./configure --prefix=$(installDir)
	cd $1 && make -j2
	cd $1 && make install

endef

define config_n_make_modules
$(foreach var, $1,$(call config_n_make, $(var)))
endef
