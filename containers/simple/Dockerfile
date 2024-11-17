# Use the official Nginx image as a base
FROM nginx:latest

# Install Redis, Supervisor, and Fail2ban
RUN apt update && \
    apt install -y redis-server supervisor fail2ban procps nodejs npm && \
    apt clean

# Copy the supervisor configuration file
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Copy custom Nginx configuration file
COPY nginx.conf /etc/nginx/nginx.conf

# Copy fail2ban configuration files
COPY jail.local /etc/fail2ban/jail.local
COPY nginx-redis.conf /etc/fail2ban/filter.d/nginx-redis.conf

# Copy middleman (websocket connector)
COPY middleman/ /usr/share/middleman
WORKDIR /usr/share/middleman
RUN npm install

WORKDIR /

# Expose ports
EXPOSE 80 6379

# Start supervisord to manage Nginx, Redis, and Fail2ban
CMD ["/usr/bin/supervisord"]