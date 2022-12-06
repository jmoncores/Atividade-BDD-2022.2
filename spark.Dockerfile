## build our image on top of Debian latest version
FROM debian:latest

## initial directory
WORKDIR /home/

## install necessary packages
ENV DEBIAN_FRONTEND=noninteractive 

RUN apt-get update && apt-get install -y curl vim wget software-properties-common ssh net-tools ca-certificates python3 python3-pip python3-numpy python3-matplotlib python3-scipy python3-pandas
RUN apt-get update && apt-get install -y python3-simpy3

## set python3 as default
RUN update-alternatives --install "/usr/bin/python" "python" "$(which python3)" 1

## move jdk and spark installers from downloads folder at the host to /home in the container
COPY downloads/* /home/

RUN mkdir -p /usr/local/oracle-java-17
RUN tar -zxf jdk-17_linux-x64_bin.tar.gz -C /usr/local/oracle-java-17/
RUN rm  jdk-17_linux-x64_bin.tar.gz
RUN update-alternatives --install "/usr/bin/java" "java" "/usr/local/oracle-java-17/jdk-17.0.5/bin/java" 1
RUN update-alternatives --install "/usr/bin/javac" "javac" "/usr/local/oracle-java-17/jdk-17.0.5/bin/javac" 1
ENV JAVA_HOME="/usr/local/oracle-java-17/jdk-17.0.5"

## configure spark
RUN mkdir -p /usr/local/spark-3.3.1
RUN tar -zxf spark-3.3.1-bin-hadoop3.tgz -C /usr/local/spark-3.3.1/
RUN rm spark-3.3.1-bin-hadoop3.tgz
RUN update-alternatives --install "/usr/sbin/start-master" "start-master" "/usr/local/spark-3.3.1/spark-3.3.1-bin-hadoop3/sbin/start-master.sh" 1
RUN update-alternatives --install "/usr/sbin/start-slave" "start-slave" "/usr/local/spark-3.3.1/spark-3.3.1-bin-hadoop3/sbin/start-slave.sh" 1
RUN update-alternatives --install "/usr/sbin/start-slaves" "start-slaves" "/usr/local/spark-3.3.1/spark-3.3.1-bin-hadoop3/sbin/start-slaves.sh" 1
RUN update-alternatives --install "/usr/sbin/start-worker" "start-worker" "/usr/local/spark-3.3.1/spark-3.3.1-bin-hadoop3/sbin/start-worker.sh" 1
RUN update-alternatives --install "/usr/sbin/start-workers" "start-workers" "/usr/local/spark-3.3.1/spark-3.3.1-bin-hadoop3/sbin/start-workers.sh" 1
RUN update-alternatives --install "/usr/sbin/start-all" "start-all" "/usr/local/spark-3.3.1/spark-3.3.1-bin-hadoop3/sbin/start-all.sh" 1
RUN update-alternatives --install "/usr/sbin/stop-all" "stop-all" "/usr/local/spark-3.3.1/spark-3.3.1-bin-hadoop3/sbin/stop-all.sh" 1
RUN update-alternatives --install "/usr/sbin/stop-master" "stop-master" "/usr/local/spark-3.3.1/spark-3.3.1-bin-hadoop3/sbin/stop-master.sh" 1
RUN update-alternatives --install "/usr/sbin/stop-slaves" "stop-slaves" "/usr/local/spark-3.3.1/spark-3.3.1-bin-hadoop3/sbin/stop-slaves.sh" 1
RUN update-alternatives --install "/usr/sbin/stop-slave" "stop-slave" "/usr/local/spark-3.3.1/spark-3.3.1-bin-hadoop3/sbin/stop-slave.sh" 1
RUN update-alternatives --install "/usr/sbin/start-worker" "start-worker" "/usr/local/spark-3.3.1/spark-3.3.1-bin-hadoop3/sbin/stop-worker.sh" 1
RUN update-alternatives --install "/usr/sbin/start-workers" "start-workers" "/usr/local/spark-3.3.1/spark-3.3.1-bin-hadoop3/sbin/stop-workers.sh" 1
RUN update-alternatives --install "/usr/sbin/spark-daemon.sh" "spark-daemon.sh" "/usr/local/spark-3.3.1/spark-3.3.1-bin-hadoop3/sbin/spark-daemon.sh" 1
RUN update-alternatives --install "/usr/sbin/spark-config.sh" "spark-config.sh" "/usr/local/spark-3.3.1/spark-3.3.1-bin-hadoop3/sbin/spark-config.sh" 1
RUN update-alternatives --install "/usr/bin/spark-shell" "spark-shell" "/usr/local/spark-3.3.1/spark-3.3.1-bin-hadoop3/bin/spark-shell" 1
RUN update-alternatives --install "/usr/bin/spark-class" "spark-class" "/usr/local/spark-3.3.1/spark-3.3.1-bin-hadoop3/bin/spark-class" 1
RUN update-alternatives --install "/usr/bin/spark-sql" "spark-sql" "/usr/local/spark-3.3.1/spark-3.3.1-bin-hadoop3/bin/spark-sql" 1
RUN update-alternatives --install "/usr/bin/spark-submit" "spark-submit" "/usr/local/spark-3.3.1/spark-3.3.1-bin-hadoop3/bin/spark-submit" 1
RUN update-alternatives --install "/usr/bin/pyspark" "pyspark" "/usr/local/spark-3.3.1/spark-3.3.1-bin-hadoop3/bin/pyspark" 1
RUN update-alternatives --install "/usr/bin/load-spark-env.sh" "load-spark-env.sh" "/usr/local/spark-3.3.1/spark-3.3.1-bin-hadoop3/bin/load-spark-env.sh" 1
ENV SPARK_HOME="/usr/local/spark-3.3.1/spark-3.3.1-bin-hadoop3"