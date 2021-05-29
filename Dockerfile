FROM node:14.16.1-alpine
RUN apk update  
RUN apk add --no-cache bash curl file git zip wget

RUN wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub
RUN wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.33-r0/glibc-2.33-r0.apk
RUN apk add glibc-2.33-r0.apk
# RUN apt-get clean

# Clone the flutter repo
RUN git clone https://github.com/flutter/flutter.git /usr/local/flutter

# Set flutter path
ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:${PATH}"

# Enable flutter web
RUN flutter channel master
RUN flutter upgrade
RUN flutter config --enable-web

# Run flutter doctor
RUN flutter doctor -v


RUN npm install -g npm pm2

# Copy the app files to the container
COPY . /usr/local/bin/app


# Set the working directory to the app files within the container
WORKDIR /usr/local/bin/app

# Get App Dependencies
RUN flutter pub get

RUN flutter precache --web


# RUN touch /usr/local/bin/flutter.pid
# Build the app for the web

# Document the exposed port
EXPOSE 3000

# Set the server startup script as executable
# Start the web server
ENTRYPOINT ["/bin/sh", "-c", "pm2 start && pm2 logs code-wae-app" ]