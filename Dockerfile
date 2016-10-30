FROM ubuntu:16.04

MAINTAINER Yasutaka Kawamoto

# update
RUN apt-get update

# for slack notification
RUN apt-get -y install curl

# Install for running 32-bit applications
# 64-bit distribution capable of running 32-bit applications
# https://developer.android.com/studio/index.html
RUN apt-get -y install lib32stdc++6 lib32z1

# Install Java8
RUN apt-get install -y openjdk-8-jdk

# Download Android SDK
RUN apt-get -y install wget \
  && cd /usr/local \
  && wget http://dl.google.com/android/android-sdk_r25.2.2-linux.tgz \
  && tar zxvf android-sdk_r25.2.2-linux.tgz \
  && rm -rf /usr/local/android-sdk_r25.2.2-linux.tgz

# Environment variables
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
ENV ANDROID_HOME /usr/local/android-sdk-linux
ENV PATH $ANDROID_HOME/platform-tools:$ANDROID_HOME/tools:$PATH
#ENV ANDROID_EMULATOR_FORCE_32BIT true

# Update of Android SDK
RUN echo y | android update sdk --no-ui --all --filter "android-25,build-tools-25.0.0" \
  && echo y | android update sdk --no-ui --all --filter "extra-android-support,extra-google-m2repository,extra-android-m2repository,extra-google-google_play_services" \
  && echo y | android update sdk -a -u -t "sys-img-armeabi-v7a-android-24"

# For DeployGate
RUN apt-get -y install build-essential ruby ruby-dev