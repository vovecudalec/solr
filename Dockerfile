FROM ubuntu

RUN  apt-get update && apt-get install -y software-properties-common

# Install Java 7
RUN \
  echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  add-apt-repository -y ppa:webupd8team/java && \
  apt-get update && \
  apt-get install -y oracle-java7-installer && \
  rm -rf /var/lib/apt/lists/* && \
  rm -rf /var/cache/oracle-jdk7-installer

ENV JAVA_HOME /usr/lib/jvm/java-7-oracle


# Install wget tomcat7
RUN  apt-get update \
  && apt-get install -y wget tomcat7 tomcat7-user \
  && rm -rf /var/lib/apt/lists/*


#RUN groupadd -g 9000 tomcat && \
# useradd -d /tomcat -r -s /bin/false -g 9000 -u 9000 tomcat && \ 
# tomcat7-instance-create /tomcat && \
# chown -R tomcat:tomcat /tomcat

RUN tomcat7-instance-create /tomcat

# Add volumes for volatile directories that aren't usually shared with child images.
VOLUME ["/tomcat/logs", "/tomcat/temp", "/tomcat/work"]

# Expose HTTP only by default.
EXPOSE 8080

# Workaround for https://bugs.launchpad.net/ubuntu/+source/tomcat7/+bug/1232258
RUN ln -s /var/lib/tomcat7/common/ /usr/share/tomcat7/common && \
 ln -s /var/lib/tomcat7/server/ /usr/share/tomcat7/server && \
 ln -s /var/lib/tomcat7/shared/ /usr/share/tomcat7/shared

# Use IPv4 by default and UTF-8 encoding. These are almost universally useful.
ENV JAVA_OPTS -Djava.net.preferIPv4Stack=true -Dfile.encoding=UTF-8

#RUN rm -Rf /tomcat

# All your base...
ENV CATALINA_BASE /tomcat

# get Solr
ENV SOLR_URL https://raw.githubusercontent.com/DrWolf-OSS/docker-alfresco/master/templates/alf_data/solr/apache-solr-1.4.1.war
RUN wget -O apache-solr.war $SOLR_URL\
	&& mv apache-solr.war $CATALINA_BASE/webapps/

# Drop privileges and run Tomcat.
#USER tomcat
CMD /usr/share/tomcat7/bin/catalina.sh run
