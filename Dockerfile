FROM eclipse-temurin:17-jdk-jammy

# Crear usuario para SSH
RUN useradd -ms /bin/bash jhon

# Instalar OpenSSH
RUN apt-get update && \
    apt-get install -y openssh-server && \
    mkdir /var/run/sshd && \
    rm -rf /var/lib/apt/lists/*

# Configurar SSH para el usuario
RUN mkdir -p /home/jhon/.ssh && \
    chown -R jhon:jhon /home/jhon/.ssh && \
    chmod 700 /home/jhon/.ssh

# Crear carpeta de despliegue del artefacto
RUN mkdir -p /home/jhon/staging && \
    chown -R jhon:jhon /home/jhon/staging

# Exponer puertos
EXPOSE 8080

# Iniciar solo SSH (la app la lanzas con Jenkins por ssh)
CMD ["/usr/sbin/sshd", "-D"]