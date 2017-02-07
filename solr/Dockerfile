FROM tomcat7

#
# setup Solr
#

ENV ALFRESCO_SOLR_DIR /Alfresco/solr
ENV ALFRESCO_SOLR_LOGS $ALFRESCO_SOLR_DIR/logs

ENV SOLR_ARCHIVE_NAME korus_patched_solr.zip
ENV SOLR_URL https://github.com/vovecudalec/solr/raw/master/$SOLR_ARCHIVE_NAME

RUN mkdir /Alfresco
RUN mkdir $ALFRESCO_SOLR_DIR
RUN mkdir $ALFRESCO_SOLR_LOGS

RUN wget $SOLR_URL \
    && unzip $SOLR_ARCHIVE_NAME -d $ALFRESCO_SOLR_DIR

RUN mkdir -p $CATALINA_HOME/conf/Catalina/localhost/

RUN cp -f $ALFRESCO_SOLR_DIR/context.xml $CATALINA_HOME/conf/Catalina/localhost/solr.xml
COPY solrcore.properties $ALFRESCO_SOLR_DIR/workspace-SpacesStore/conf/solrcore.properties
COPY solrcore.properties $ALFRESCO_SOLR_DIR/archive-SpacesStore/conf/solrcore.properties

CMD /opt/apache-tomcat-7.0.75/bin/catalina.sh start && tail -f /opt/apache-tomcat-7.0.75/logs/catalina.out


