FROM java:8-jdk-alpine
RUN addgroup -S spring && adduser -S spring -G spring
VOLUME /tmp
ARG DEPENDENCY=deps
COPY entrypoint.sh entrypoint.sh
RUN chown spring:spring entrypoint.sh
RUN chmod +x entrypoint.sh
USER spring:spring
COPY ${DEPENDENCY}/BOOT-INF/lib /app/lib
COPY ${DEPENDENCY}/META-INF /app/META-INF
COPY ${DEPENDENCY}/BOOT-INF/classes /app
ENTRYPOINT ["./entrypoint.sh"]