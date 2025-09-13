# Dockerfile corrigé — Node 20 + bullseye (compatible @whiskeysockets/baileys)
FROM node:20-bullseye

# éviter les prompts apt
ENV DEBIAN_FRONTEND=noninteractive
ENV NODE_ENV=production
WORKDIR /usr/src/app

# installer dépendances système nécessaires puis nettoyer
RUN apt-get update && \
    apt-get install -y --no-install-recommends ffmpeg imagemagick webp && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# copier package.json + package-lock.json (si présent) pour tirer parti du cache Docker
COPY package*.json ./

# installer dépendances node; installer outils globaux si nécessaire
RUN npm ci --only=production || npm install && \
    npm install -g qrcode-terminal pm2 --no-fund --no-audit

# copier le reste du code
COPY . .

# exposer le port utilisé par l'app
EXPOSE 5000

# commande de démarrage (assure-toi que "start" est défini dans package.json)
CMD ["npm", "start"]
