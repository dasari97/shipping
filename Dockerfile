FROM            maven
RUN             useradd -m -d /app roboshop
USER            roboshop
WORKDIR         /app
COPY            src/ src/
COPY            pom.xml .
RUN             mvn clean package
ENTRYPOINT      ["java", "-jar", "target/shipping-1.0.jar"]