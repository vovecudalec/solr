FROM ubuntu

ENV ALFRESCO_SOLR_DIR /Alfresco/solr
ENV ALFRESCO_SOLR_LOGS $ALFRESCO_SOLR_DIR/logs
ENV CATALINA_BASE /tomcat$ALFRESCO_SOLR_DIR


RUN mkdir /Alfresco
RUN mkdir $ALFRESCO_SOLR_DIR
RUN mkdir $ALFRESCO_SOLR_LOGS


# Install wget tomcat7
RUN  apt-get update \
  && apt-get install -y wget \
    tomcat7 \
    tomcat7-docs \
    tomcat7-admin \
    tomcat7-examples \
#    mc\
#    tomcat7-user \
    net-tools \
    unzip \
  && rm -rf /var/lib/apt/lists/*

#RUN tomcat7-instance-create /tomcat
# Expose HTTP only by default.
EXPOSE 8080
EXPOSE 8983

# Workaround for https://bugs.launchpad.net/ubuntu/+source/tomcat7/+bug/1232258
RUN ln -s /var/lib/tomcat7/common/ /usr/share/tomcat7/common && \
 ln -s /var/lib/tomcat7/server/ /usr/share/tomcat7/server && \
 ln -s /var/lib/tomcat7/shared/ /usr/share/tomcat7/shared

#RUN wget $SOLR_URL \
#    && unzip $SOLR_ARCHIVE_NAME -d $ALFRESCO_SOLR_DIR

#RUN cp -f $ALFRESCO_SOLR_DIR/context.xml $CATALINA_BASE/conf/context.xml


#ADD settings.xml /usr/local/tomcat/conf/
#ADD tomcat-users.xml /usr/local/tomcat/conf/


CMD /usr/share/tomcat7/bin/catalina.sh run
#&& tail -f /var/log/tomcat7/catalina.out
