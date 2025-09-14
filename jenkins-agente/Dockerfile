FROM jenkins/agent:latest

USER root
# Instala las dependencias necesarias para Docker
RUN apt-get update && apt-get install -y apt-transport-https ca-certificates curl gnupg2

# Agrega la llave GPG de Docker
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Configura el repositorio de Docker usando "bookworm"
RUN echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian bookworm stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

# Instala el cliente de Docker
RUN apt-get update && apt-get install -y docker-ce-cli

# Restaura el usuario a jenkins
USER jenkins