FROM us.gcr.io/sequislife-pilot/java
RUN java -version
VOLUME /tmp
EXPOSE 9180
COPY gs-maven-0.1.0-shaded.jar /gs-maven-0.1.0-shaded.jar
CMD ["java" "-jar" "/gs-maven-0.1.0.jar"]
