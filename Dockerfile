# syntax=docker/dockerfile:1

FROM ubuntu:22.04

#install dependencies
##update
RUN apt-get update
##wget
RUN apt-get install -y wget
##vnc
RUN apt-get install xfce4 xfce4-goodies -y
RUN apt-get install tightvncserver -y

RUN apt-get install --reinstall libgtk2.0-0 -y
##to delete graphical warning
RUN apt-get install gtk2-engines-pixbuf -y
##to avoid window system error
RUN apt-get purge --auto-remove xfce4-power-manager -y
##delete apt package list
RUN rm -rf /var/lib/apt/lists/*

#add user
RUN adduser --disabled-password --gecos '' user
WORKDIR /home/user/db-main
#download and extract software
RUN wget https://projects.info.unamur.be/dbmain/files/dbm-1102-linux-amd64-setup.tar.gz
RUN tar -xf dbm-1102-linux-amd64-setup.tar.gz
RUN rm dbm-1102-linux-amd64-setup.tar.gz
#copy scripts
WORKDIR /home/user/Desktop/
COPY db-main.sh .
RUN chmod +x db-main.sh
COPY startVNC.sh .
RUN chmod +x startVNC.sh
COPY stopVNC.sh .
RUN chmod +x stopVNC.sh

USER user
#to avoid first run error
RUN mkdir /home/user/.db-main
RUN touch /home/user/.db-main/db_main.ini

ENV SCREEN_RESOLUTION=1920x1080
VOLUME /home/user/Desktop/Exercises
EXPOSE 5901