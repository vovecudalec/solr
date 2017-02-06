FROM ubuntu

ENV ALFRESCO_SOLR_DIR /Alfresco/solr
ENV ALFRESCO_SOLR_LOGS $ALFRESCO_SOLR_DIR/logs
ENV CATALINA_BASE /tomcat
ENV SOLR_ARCHIVE_NAME korus_patched_solr.zip
ENV SOLR_URL https://github.com/vovecudalec/solr/raw/master/$SOLR_ARCHIVE_NAME


RUN mkdir /Alfresco
RUN mkdir $ALFRESCO_SOLR_DIR
RUN mkdir $ALFRESCO_SOLR_LOGS


# Install wget tomcat7
RUN  apt-get update \
  && apt-get install -y wget tomcat7 tomcat7-user net-tools unzip \
  && rm -rf /var/lib/apt/lists/*

RUN tomcat7-instance-create /tomcat

RUN wget $SOLR_URL \
    && unzip $SOLR_ARCHIVE_NAME -d $ALFRESCO_SOLR_DIR

# Expose HTTP only by default.
EXPOSE 8080

# Workaround for https://bugs.launchpad.net/ubuntu/+source/tomcat7/+bug/1232258
RUN ln -s /var/lib/tomcat7/common/ /usr/share/tomcat7/common && \
 ln -s /var/lib/tomcat7/server/ /usr/share/tomcat7/server && \
 ln -s /var/lib/tomcat7/shared/ /usr/share/tomcat7/shared

CMD /usr/share/tomcat7/bin/catalina.sh run
