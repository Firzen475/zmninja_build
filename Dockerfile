FROM ubuntu:20.04 as zmninja_build

#Установка cron и ssh
RUN mkdir -p /zmninja && mkdir -p /release && set -eux; \
	apt-get update && apt-get -y install software-properties-common && add-apt-repository ppa:openjdk-r/ppa \
	&& DEBIAN_FRONTEND=noninteractive TZ=Asia/Yekaterinburg apt-get -y install tzdata gradle curl wget git zip openjdk-11-jdk-headless \
	&& curl -sL https://deb.nodesource.com/setup_16.x | bash \
        && apt-get update && apt-get -y install nodejs

RUN mkdir -p /android/sdk && cd /android/sdk \
        && wget https://dl.google.com/android/repository/commandlinetools-linux-9123335_latest.zip \
        && unzip commandlinetools-linux-9123335_latest.zip && mkdir /android/sdk/tools \
        && mv -i /android/sdk/cmdline-tools/* /android/sdk/tools && mv -i /android/sdk/tools /android/sdk/cmdline-tools/

RUN yes | /android/sdk/cmdline-tools/tools/bin/sdkmanager --licenses \
	&& /android/sdk/cmdline-tools/tools/bin/sdkmanager "build-tools;33.0.2"

WORKDIR /root

RUN npm update \
	&& npm install -g cordova @ionic/cli@6.9.3 @ionic/v1-toolkit@1.0.22 cordova-android@^12.0.0 cordova-res gulp node-sass async jshint
	
VOLUME /zmninja /release

WORKDIR /zmninja
# lib.zip: https://github.com/apache/cordova-plugin-file-transfer.git https://github.com/dpa99c/cordova-plugin-cloud-settings.git
COPY lib.zip entrypoint.sh /root/

RUN chmod +x /root/entrypoint.sh

ENTRYPOINT ["/root/entrypoint.sh"]
