FROM java:8
MAINTAINER Jacek Ciolek <j.ciolek@webnicer.com>
ADD https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar /tmp/
WORKDIR /tmp
RUN java -jar BuildTools.jar && \
    mkdir -p /usr/local/lib/minecraft && \
    cp /tmp/spigot-*.jar /usr/local/lib/minecraft/spigot.jar && \
    cp /tmp/craftbukkit-*.jar /usr/local/lib/minecraft/craftbukkit.jar && \
    mkdir -p /minecraft && \
    echo "eula=true" > /minecraft/eula.txt
VOLUME /minecraft
EXPOSE 25565
WORKDIR /minecraft
CMD java -Xms512M -Xmx1536M -XX:MaxPermSize=128M -jar /usr/local/lib/minecraft/spigot.jar
