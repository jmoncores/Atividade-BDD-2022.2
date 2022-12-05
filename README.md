# Atividade-BDD-2022.2
Arquivos relacionados à atividade prática da disciplina Bancos de Dados Distribuídos.

### General Resources:
Docker Desktop 4.14.1 for Windows

### Docker image resources:
Base image debian:latest  
Oracle jdk-17.0.5   
Python 3.9.2  
Ppyspark   
Spark 3.3.1   

### How to create and instantiate the containers:
1. Download the dockerfile, jdk and spark. The jdk and spark installers must be inside a folder named downloads.
├── ...  
├── downloads   
│   ├── jdk   
│   └── spark   
└── spark.dockerfile   

2. From the directory where is located the dockerfile, open cmd prompt and build the image "docker build -f spark.Dockerfile -t jmonc/spark-debian ."   
3. Create a network "docker network create --driver bridge spark-network"     
4. Create a volume "docker volume create spark-volume"  
5. Instantiate the master   
"docker run -d -t --name master-spark -v spark-volume:/aplicacoes --network spark-network -p 8080:8080 -p 7077:7077 jmonc/spark-debian"   
6. Instantiate the workers   
"docker run -d -t -m 512m --cpus 1 --name worker-spark-1 -v spark-volume:/aplicacoes  --network spark-network -p 8081:8081 jmonc/spark-debian"   
"docker run -d -t -m 512m --cpus 1 --name worker-spark-2 -v spark-volume:/aplicacoes  --network spark-network -p 8082:8081 jmonc/spark-debian"   
7. Execute the scripts   
"docker exec master-spark start-master"  
"docker exec worker-spark-1 start-worker spark://master-spark:7077"   
"docker exec worker-spark-2 start-worker spark://master-spark:7077"   

### How to create and instantiate the containers:



### Credits:
Thiago Melo at https://medium.com/@thiagolcmelo/submitting-a-python-job-to-apache-spark-on-docker-b2bd19593a06  
Marco Villarreal at https://dev.to/mvillarrealb/creating-a-spark-standalone-cluster-with-docker-and-docker-compose-2021-update-6l4  
André Perez at https://www.kdnuggets.com/2020/07/apache-spark-cluster-docker.html  
