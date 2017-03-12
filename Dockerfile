FROM ubuntu:16.04

# system update 50MB程度
RUN apt-get -y update \
    ;unlink /etc/localtime \
    ;ln -s /usr/share/zoneinfo/Japan /etc/localtime

#RUN yum group install -y "Japanese Support"
RUN localedef -f UTF-8 -i ja_JP ja_JP

ENV LANG=ja_JP.UTF-8 \
    LC_CTYPE=ja_JP.UTF-8 \
    LC_NUMERIC=ja_JP.UTF-8 \
    LC_TIME=ja_JP.UTF-8 \
    LC_COLLATE=ja_JP.UTF-8 \
    LC_MONETARY=ja_JP.UTF-8 \
    LC_MESSAGES=ja_JP.UTF-8 \
    LC_PAPER=ja_JP.UTF-8 \
    LC_NAME=ja_JP.UTF-8 \
    LC_ADDRESS=ja_JP.UTF-8 \
    LC_TELEPHONE=ja_JP.UTF-8 \
    LC_MEASUREMENT=ja_JP.UTF-8 \
    LC_IDENTIFICATION=ja_JP.UTF-8 \
    LC_ALL=ja_JP.UTF-8 \
    LANGUAGE=ja_JP:ja

## https://github.com/dotnet/core/blob/master/release-notes/download-archive.md
#RUN apt-get -y update \
#    ;apt-get -y install kbd \
#                       nano \
#                       apt-transport-https \
#    ;sh -c 'echo "deb [arch=amd64] https://apt-mo.trafficmanager.net/repos/dotnet-release/ xenial main" > /etc/apt/sources.list.d/dotnetdev.list' \
#    ;apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 417A0893 \
#    ;apt-get -y update \
#    ;apt-get -y install dotnet-dev-1.0.0-preview2-003131

ENV DOTNET_SKIP_FIRST_TIME_EXPERIENCE=true \
    UGET_XMLDOC_MODE=skip
#ENV ASPNETCORE_ENVIROMENT=Development,Staging,Production

#How to Use
#docker build -t <tag> .
#docker run -it -p 5000:5000 <tag> /bin/bash
#dotnet restore
#dotnet build
#ASPNETCORE_URLS="http://*:5000" dotnet run
#curl http://192.168.99.100:5000

#---------------------------------------------------------------------
#RUN apt-get -y install xrdp
RUN apt-get -y install xrdp lxde
#RUN apt-get -y install xrdp xfce4 language-pack-ja fonts-vlgothic
#RUN apt-get -y install xubuntu-desktop
#RUN apt-get -y install lubuntu-desktop
#RUN apt-get -y install lxde
#RUN apt-get -y install ibus-anthy
#RUN apt-get -y install ibus-mozc
#RUN apt-get -y install pcmanfm
#RUN apt-get install -y supervisor
#RUN apt-get autoclean && apt-get autoremove && \
#    rm -rf /var/lib/apt/lists/* && \
RUN useradd -ms /bin/bash desktop && \
    sed -i '/TerminalServerUsers/d' /etc/xrdp/sesman.ini && \
    sed -i '/TerminalServerAdmins/d' /etc/xrdp/sesman.ini && \
    xrdp-keygen xrdp auto && \
    echo "desktop:desktop" | chpasswd
ADD xrdp.conf /etc/supervisor/conf.d/xrdp.conf 
CMD ["/usr/bin/supervisord", "-n"]

#RUN apt-get update -y && \
#     apt-get install -y mate-core \ 
#     mate-desktop-environment mate-notification-daemon \ 
#     gconf-service libnspr4 libnss3 fonts-liberation \ 
#     libappindicator1 libcurl3 fonts-wqy-microhei firefox && \ 
#     apt-get autoclean && apt-get autoremove && \ 
#     rm -rf /var/lib/apt/lists/* && \ 
#     echo "mate-session" > /home/desktop/.xsession
RUN apt-get install -y ttf-kochi-gothic xfonts-intl-japanese xfonts-intl-japanese-big
RUN apt-get install -y language-pack-ja
#RUN update-locale LANG=ja_JP.UTF-8

RUN echo "root:root" | chpasswd