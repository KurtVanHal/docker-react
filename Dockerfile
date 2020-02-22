# Dockerfile die de image zal opbouwen voor productie
# Hier wordt gebruik gemaakt van een multi step build
# De workflow gebeurt in 2 fasen (de build phase en de run phase) 

# Algemene flow
# 1. node => installeer dependencies => kopieer alles => npm run build
# 2. nginx => kopieer build uit 1ste fase => CMD niet nodig (default ingesteld)

# BUILD PHASE
FROM node:alpine as builder
WORKDIR /app
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# RUN PHASE (door een 2de FROM statement weet docker dat de build phase voltooid is)
FROM nginx
# kopieer van een andere fase (builder)
# bestemmingsfolder is eigen aan nginx (zie docker hub)
COPY --from=builder /app/build /usr/share/nginx/html
# CMD is niet nodig => default CMD voor opstarten is al voorzien in nginx