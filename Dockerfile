FROM eatcode/openjdk8

MAINTAINER Ayub Malik <ayub.malik@gmail.com>

ENV HZ_VERSION 3.6.2

ENV HZ_HOME /opt/hazelcast/

LABEL name="hazelcast" version="$HZ_VERSION"

RUN wget -q -O - "http://download.hazelcast.com/download.jsp?version=hazelcast-${HZ_VERSION}&type=tar&p=177120386177120386" | tar -xzf - -C /opt \
    && ln -s /opt/hazelcast-${HZ_VERSION} /opt/hazelcast

ADD hazelcast.xml ${HZ_HOME}/bin

ENV CLASSPATH=$HZ_HOME/lib/hazelcast-${HZ_VERSION}.jar

EXPOSE 5701

VOLUME /opt/hazelcast/applib

CMD java -Xms1g -Xmx2g -server -Dhazelcast.config=$HZ_HOME/bin/hazelcast.xml com.hazelcast.core.server.StartServer
