
# Rekòmande: image ki pa gen problèm ak dépôts
FROM node:18-bullseye

ENV DEBIAN_FRONTEND=noninteractive
WORKDIR /usr/src/app

# Met --no-install-recommends pou limen gwosè imaj la, netwaye apre
RUN apt-get update && \
    apt-get install -y --no-install-recommends ffmpeg imagemagick webp && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Kopi fichye package yo an premye pou cache layer npm
COPY package*.json ./

# Enstale dependances (epi enstale global tools si bezwen)
RUN npm install && \
    npm install -g qrcode-terminal pm2

# Kopi rès kòd la
COPY . .

EXPOSE 5000

CMD ["npm", "start"]
