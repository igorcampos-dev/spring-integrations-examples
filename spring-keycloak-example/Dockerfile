FROM eclipse-temurin:25.0.2_10-jdk-jammy as deps

WORKDIR /build

COPY --chmod=0755 mvnw mvnw
COPY .mvn/ .mvn/

RUN --mount=type=bind,source=pom.xml,target=pom.xml \
    --mount=type=cache,target=/root/.m2 ./mvnw dependency:go-offline -DskipTests

FROM deps as package

WORKDIR /build

COPY ./src src/
RUN --mount=type=bind,source=pom.xml,target=pom.xml \
    --mount=type=cache,target=/root/.m2 \
    ./mvnw package -DskipTests && \
    mv target/$(./mvnw help:evaluate -Dexpression=project.artifactId -q -DforceStdout)-$(./mvnw help:evaluate -Dexpression=project.version -q -DforceStdout).jar target/app.jar

FROM eclipse-temurin:25.0.2_10-jre-jammy AS final

#<IT IS NOT NECESSARY IN PRODUCTION ---
RUN apt-get update && apt-get install -y nginx supervisor && rm -rf /var/lib/apt/lists/*
COPY docker/nginx/nginx.conf /etc/nginx/nginx.conf
COPY docker/nginx/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
#--- IT IS NOT NECESSARY IN PRODUCTION>

COPY --from=package /build/target/app.jar /app/app.jar

EXPOSE 8083 8080

ENTRYPOINT ["supervisord", "-n"]
