FROM prettysmile/java

# Here comes the tomcat installation
RUN apt-get -y install \
    tomcat7 \
    wget \
    unzip


ENV TOMCAT_FILE_NAME apache-tomcat-7.0.75.tar.gz
ENV TOMCAT_URL http://apache-mirror.rbc.ru/pub/apache/tomcat/tomcat-7/v7.0.75/bin
ENV CATALINA_HOME /opt/apache-tomcat-7.0.75

RUN wget $TOMCAT_URL/$TOMCAT_FILE_NAME
RUN mkdir $CATALINA_HOME
RUN tar xf $TOMCAT_FILE_NAME -C /opt

RUN echo "JAVA_HOME=/usr/lib/jvm/java-7-oracle" >> $CATALINA_HOME/bin/setenv.sh

COPY tomcat-users.xml $CATALINA_HOME/conf/
COPY setenv.sh $CATALINA_HOME/bin/

RUN chmod 755 $CATALINA_HOME/bin/setenv.sh
#
## Expose the default tomcat port
EXPOSE 8080

RUN /opt/apache-tomcat-7.0.75/bin/catalina.sh start

