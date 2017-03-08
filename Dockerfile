FROM centos:7

# system update 50MB程度
RUN yum -y update && yum clean all

# set locale
RUN unlink /etc/localtime
RUN ln -s /usr/share/zoneinfo/Japan /etc/localtime

RUN yum reinstall -y glibc-common
RUN yum reinstall -y glibc

#RUN yum group install -y "Japanese Support"
RUN localedef -f UTF-8 -i ja_JP ja_JP

ENV LANG ja_JP.UTF-8
ENV LC_CTYPE ja_JP.UTF-8
ENV LC_NUMERIC ja_JP.UTF-8
ENV LC_TIME ja_JP.UTF-8
ENV LC_COLLATE ja_JP.UTF-8
ENV LC_MONETARY ja_JP.UTF-8
ENV LC_MESSAGES ja_JP.UTF-8
ENV LC_PAPER ja_JP.UTF-8
ENV LC_NAME ja_JP.UTF-8
ENV LC_ADDRESS ja_JP.UTF-8
ENV LC_TELEPHONE ja_JP.UTF-8
ENV LC_MEASUREMENT ja_JP.UTF-8
ENV LC_IDENTIFICATION ja_JP.UTF-8
ENV LC_ALL ja_JP.UTF-8
ENV LANGUAGE ja_JP:ja

RUN yum -y install kbd

## dotnet core
RUN yum -y install libunwind libicu
RUN yum clean all
## https://github.com/dotnet/core/blob/master/release-notes/download-archive.md
RUN curl -sSL -o dotnet_preview2_003131.tar.gz https://go.microsoft.com/fwlink/?LinkID=827529
RUN mkdir -p /opt/dotnet && tar zxf dotnet_preview2_003131.tar.gz -C /opt/dotnet
RUN ln -s /opt/dotnet/dotnet /usr/local/bin

RUN ln -s /opt/dotnet/dotnet /usr/local/bin

#ENV DOTNET_SKIP_FIRST_TIME_EXPERIENCE true
#ENV UGET_XMLDOC_MODE skip
#ENV ASPNETCORE_ENVIROMENT=Development,Staging,Production

#How to Use
#docker build -t <tag> .
#docker run -v /c/Users/taro/Desktop/work/IdentityServer4Authentication:/root -it -p 2704:2704 centosjp /bin/bash
#docker run -v {PWD}:/root -it -p 2704:2704 centosjp /bin/bash
#dotnet restore
#dotnet build
#ASPNETCORE_URLS="http://*:2704" dotnet run
#curl http://192.168.99.100:5000
