# Usa la imagen de agente base de Jenkins
FROM jenkins/inbound-agent:4.11-1-jdk11

USER root
# Instala las dependencias necesarias para Docker
RUN apt-get update && apt-get install -y apt-transport-https ca-certificates curl gnupg2

# Agrega la llave GPG oficial de Docker
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Configura el repositorio de Docker usando el nombre de la distribución
RUN echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian bullseye stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

# Instala el cliente de Docker
RUN apt-get update && apt-get install -y docker-ce-cli

# Restaura el usuario a jenkins
USER jenkins