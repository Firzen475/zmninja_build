#!/usr/bin/env bash


export ANDROID_HOME=/android/sdk
export PATH=$ANDROID_HOME/cmdline-tools/tools/bin/:$PATH
export PATH=$ANDROID_HOME/emulator/:$PATH
export PATH=$ANDROID_HOME/platform-tools/:$PATH
export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
export ANDROID_SDK_ROOT=/android/sdk
unzip /root/lib.zip -d /root >> /dev/null
#echo "//////////////////////////////////////////////"
java -version
#echo "//////////////////////////////////////////////"
javac -version
echo "//////////////////////////////////////////////"
sdkmanager --list_installed
echo "//////////////////////////////////////////////"
cordova plugin add /root/tmp/transfer/
echo "//////////////////////////////////////////////"
cordova plugin add /root/tmp/cloud/
echo "//////////////////////////////////////////////"
npm install
echo "//////////////////////////////////////////////"
ionic cordova platform add android
cordova prepare
echo "//////////////////////////////////////////////"
ionic info
echo "//////////////////////////////////////////////"
./build_android.sh --debug
rm -f /release/ZMNinja.apk
cp /zmninja/platforms/android/app/build/outputs/apk/debug/app-debug.apk /release/ZMNinja.apk
echo "//////////////////////////////////////////////"
./prepare_desktop.sh
./make_desktop.sh
rm -rf /release/zmNinja-win64bit/
cp -r /zmninja/desktop/zmNinja-win64bit/ /release/
