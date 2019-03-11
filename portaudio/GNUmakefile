down:
	wget http://www.portaudio.com/archives/pa_stable_v190600_20161030.tgz
extract:
	rm -fr portaudio
	tar xaf pa_stable_v190600_20161030.tgz
build:
	cd portaudio && \
		./configure --prefix=$(HOME)/.programs/portaudio/ --enable-cxx --with-oss --enable-debug-output
	cd portaudio && \
		make -j4
	cd portaudio && \
		make install
