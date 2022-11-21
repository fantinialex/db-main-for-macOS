# syntax=docker/dockerfile:1

FROM ubuntu:latest

RUN apt-get update
RUN apt-get install -y wget
RUN apt-get install xfce4 xfce4-goodies -y
RUN apt-get install tightvncserver -y
RUN apt-get install --reinstall libgtk2.0-0 -y
RUN rm -rf /var/lib/apt/lists/*

RUN adduser --disabled-password --gecos '' user
WORKDIR /home/user/db-main
RUN wget https://projects.info.unamur.be/dbmain/files/dbm-1102-linux-amd64-setup.tar.gz
RUN tar -xf dbm-1102-linux-amd64-setup.tar.gz
RUN rm dbm-1102-linux-amd64-setup.tar.gz
WORKDIR /home/user/Desktop/
COPY db-main.sh .
RUN chmod +x db-main.sh
COPY startVNC.sh .
RUN chmod +x startVNC.sh

RUN apt-get purge --auto-remove xfce4-power-manager -y
USER user

VOLUME /home/user/Desktop/Exercises
EXPOSE 5901