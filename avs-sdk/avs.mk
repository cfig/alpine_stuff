PA_INCLUDE := $(shell pkgconf --cflags-only-I portaudiocpp)
PA_LIBS := $(shell pkgconf --libs-only-L portaudiocpp)
PA_INC_PATH = $(shell echo -e """print('$(PA_INCLUDE)'[2:])""" | python3)
PA_LIB_PATH = $(shell echo -e """print('$(PA_LIBS)'.strip()[2:] + '/libportaudio.a')""" | python3)
srcDir := /my_volume/avs-device-sdk
buildDir := /my_volume/build
avsBinDir := avs_bin

avs:
	cd $(buildDir) && cmake $(srcDir) \
	    -DSENSORY_KEY_WORD_DETECTOR=OFF \
	    -DGSTREAMER_MEDIA_PLAYER=ON \
	    -DPORTAUDIO=ON \
	    -DPORTAUDIO_LIB_PATH=$(PA_LIB_PATH) \
	    -DPORTAUDIO_INCLUDE_DIR=$(PA_INC_PATH) \
	    -DCMAKE_BUILD_TYPE=DEBUG

config:
	bash $(srcDir)/tools/Install/genConfig.sh \
		coala_config.json \
		199834f8ebd8fb8 \
		coala_db \
		$(buildDir)/Integration/AlexaClientSDKConfig.json

copy:
	rm -fr $(avsBinDir) && mkdir $(avsBinDir)
	echo "set -x" >> $(avsBinDir)/run.sh
	echo "export GST_PLUGIN_PATH=\`pwd\`/lib:\`pwd\`/lib/gstreamer-1.0" >> $(avsBinDir)/run.sh
	echo "export LD_LIBRARY_PATH=\`pwd\`:$$GST_PLUGIN_PATH" >> $(avsBinDir)/run.sh
	echo "export GST_DEBUG=2" >> $(avsBinDir)/run.sh
	echo "./SampleApp AlexaClientSDKConfig.json DEBUG9" >> $(avsBinDir)/run.sh
	chmod 755 $(avsBinDir)/run.sh
	@cp $(buildDir)/SampleApp/src/SampleApp $(avsBinDir)/
	@cp -v $(buildDir)/ACL/src/libACL.so $(avsBinDir)/
	@cp -v $(buildDir)/ADSL/src/libADSL.so $(avsBinDir)/
	@cp -v $(buildDir)/AFML/src/libAFML.so $(avsBinDir)/
	@cp -v $(buildDir)/AVSCommon/libAVSCommon.so $(avsBinDir)/
	@cp -v $(buildDir)/ApplicationUtilities/DefaultClient/src/libDefaultClient.so $(avsBinDir)/
	@cp -v $(buildDir)/ApplicationUtilities/Resources/Audio/src/libAudioResources.so $(avsBinDir)/
	@cp -v $(buildDir)/CapabilitiesDelegate/src/libCapabilitiesDelegate.so $(avsBinDir)/
	@cp -v $(buildDir)/CapabilityAgents/AIP/src/libAIP.so $(avsBinDir)/
	@cp -v $(buildDir)/CapabilityAgents/Alerts/src/libAlerts.so $(avsBinDir)/
	@cp -v $(buildDir)/CapabilityAgents/AudioPlayer/src/libAudioPlayer.so $(avsBinDir)/
	@cp -v $(buildDir)/CapabilityAgents/Bluetooth/src/libBluetooth.so $(avsBinDir)/
	@cp -v $(buildDir)/CapabilityAgents/DoNotDisturb/src/libDoNotDisturbCA.so $(avsBinDir)/
	@cp -v $(buildDir)/CapabilityAgents/Equalizer/src/libEqualizer.so $(avsBinDir)/
	@cp -v $(buildDir)/CapabilityAgents/ExternalMediaPlayer/src/libExternalMediaPlayer.so $(avsBinDir)/
	@cp -v $(buildDir)/CapabilityAgents/InteractionModel/src/libInteractionModel.so $(avsBinDir)/
	@cp -v $(buildDir)/CapabilityAgents/Notifications/src/libNotifications.so $(avsBinDir)/
	@cp -v $(buildDir)/CapabilityAgents/PlaybackController/src/libPlaybackController.so $(avsBinDir)/
	@cp -v $(buildDir)/CapabilityAgents/Settings/src/libSettings.so $(avsBinDir)/
	@cp -v $(buildDir)/CapabilityAgents/SpeakerManager/src/libSpeakerManager.so $(avsBinDir)/
	@cp -v $(buildDir)/CapabilityAgents/SpeechSynthesizer/src/libSpeechSynthesizer.so $(avsBinDir)/
	@cp -v $(buildDir)/CapabilityAgents/System/src/libAVSSystem.so $(avsBinDir)/
	@cp -v $(buildDir)/CapabilityAgents/TemplateRuntime/src/libTemplateRuntime.so $(avsBinDir)/
	@cp -v $(buildDir)/CertifiedSender/src/libCertifiedSender.so $(avsBinDir)/
	@cp -v $(buildDir)/ContextManager/src/libContextManager.so $(avsBinDir)/
	@cp -v $(buildDir)/EqualizerImplementations/src/libEqualizerImplementations.so $(avsBinDir)/
	@cp -v $(buildDir)/MediaPlayer/GStreamerMediaPlayer/src/libMediaPlayer.so $(avsBinDir)/
	@cp -v $(buildDir)/PlaylistParser/src/libPlaylistParser.so $(avsBinDir)/
	@cp -v $(buildDir)/RegistrationManager/src/libRegistrationManager.so $(avsBinDir)/
	@cp -v $(buildDir)/SampleApp/Authorization/CBLAuthDelegate/src/libCBLAuthDelegate.so $(avsBinDir)/
	@cp -v $(buildDir)/Settings/src/libDeviceSettings.so $(avsBinDir)/
	@cp -v $(buildDir)/SpeechEncoder/src/libSpeechEncoder.so $(avsBinDir)/
	@cp -v $(buildDir)/Storage/SQLiteStorage/src/libSQLiteStorage.so $(avsBinDir)/
	@cp -v $(HOME)/.programs/gst1.15.1/lib/libgstapp-1.0.so.0 $(avsBinDir)/
	@cp -v $(HOME)/.programs/gst1.15.1/lib/libgstbase-1.0.so.0 $(avsBinDir)/
	@cp -v $(HOME)/.programs/gst1.15.1/lib/libgstreamer-1.0.so.0 $(avsBinDir)/
	@cp -v $(buildDir)/Integration/AlexaClientSDKConfig.json $(avsBinDir)/
