FROM ubuntu:20.04

ENV TZ=Asia/Jakarta

#setup first
RUN apt-get -y update && apt install tzdata -y
ENV TZ="Asia/Jakarta"
RUN apt-get install -y curl unzip build-essential nano wget mcrypt
RUN apt-get -qq update && apt-get -qq -y install bzip2
RUN apt-get install -y chrpath libssl-dev libxft-dev
RUN apt-get install -y libfreetype6 libfreetype6-dev libfontconfig1 libfontconfig1-dev


#NGINX
RUN apt-get install -y nginx



# Install ppa:ondrej/php PPA
RUN apt-get install -y software-properties-common
RUN add-apt-repository ppa:ondrej/php
RUN apt-get update

#PHP define
RUN apt-get update 
RUN apt-get install -y php8.2
#RUN apt-get install -y php-pear libapache2-mod-php8.2
RUN apt-get install -y php8.2-common php8.2-cli
RUN apt-get install -y php8.2-bz2 php8.2-zip php8.2-curl php8.2-gd php8.2-mysql php8.2-xml php8.2-dev php8.2-sqlite php8.2-mbstring php8.2-bcmath
RUN apt-get install -y php8.2-fpm

#Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer



