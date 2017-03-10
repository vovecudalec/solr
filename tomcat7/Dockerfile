FROM prettysmile/java

ENV TOMCAT_FILE_NAME apache-tomcat-7.0.75.tar.gz
ENV TOMCAT_URL http://apache-mirror.rbc.ru/pub/apache/tomcat/tomcat-7/v7.0.75/bin
ENV CATALINA_HOME /opt/apache-tomcat-7.0.75

RUN apt-get update && apt-get -y install \
    tomcat7 \
    wget \
    unzip \
    net-tools \
    vim \
    iputils-ping \
    && rm -rf /var/lib/apt/lists/* \
    && wget $TOMCAT_URL/$TOMCAT_FILE_NAME \
    && mkdir $CATALINA_HOME \
    && tar xf $TOMCAT_FILE_NAME -C /opt \
    && echo "JAVA_HOME=/usr/lib/jvm/java-7-oracle" >> $CATALINA_HOME/bin/setenv.sh \
#    && echo "CATALINA_OPTS=\"-Xmx1024m -XX:MaxPermSize=256m -XX:+UseG1GC\"" >> $CATALINA_HOME/bin/setenv.sh \
    && chmod 755 $CATALINA_HOME/bin/setenv.sh

COPY tomcat-users.xml $CATALINA_HOME/conf/
COPY server.xml $CATALINA_HOME/conf/
COPY setenv.sh $CATALINA_HOME/bin/

EXPOSE 8080 8888
