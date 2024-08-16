# Use the base Ubuntu image
FROM ubuntu:latest

# Install necessary packages including OpenSSH server and OpenJDK 8
RUN apt-get update && \
    apt-get install -y openjdk-8-jdk vim openssh-server && \
    apt-get clean

# Create a directory for the SSH daemon
RUN mkdir /var/run/sshd

# Set a root password (change 'rootpassword' to a secure password)
RUN echo 'root:12345' | chpasswd

# Allow root login via SSH
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config

# Expose SSH port
EXPOSE 22

# Start the SSH service and keep the container running
CMD ["/usr/sbin/sshd", "-D"]
