FROM node:20-alpine AS base

WORKDIR /usr/src/app
#active corepack to use pnpm
RUN corepack enable

#dependencies stage
FROM base AS dependencies
#copy all files required for installing dependencies 
COPY package.json pnpm-lock.yaml ./
#install pnpm and dependencies
RUN pnpm install --frozen-lockfile

#build stage
FROM base AS build
#copy dependencies from step before
COPY --from=dependencies /usr/src/app/node_modules ./node_modules
#copy all files to build the app
COPY . .

RUN pnpm run build

#production stage
FROM base AS production
#define working directory
WORKDIR /usr/src/app
#copy only package files to install production dependencies
COPY package.json pnpm-lock.yaml ./
#install only production dependencies
RUN pnpm install --prod --frozen-lockfile
#copy built files from build stage
COPY --from=build /usr/src/app/dist ./dist

#expose application port
EXPOSE 3001

#start application command
CMD ["node", "dist/main.js"]

