FROM node:20-alpine AS builder

WORKDIR /home/app/frontend

RUN mkdir -p node_modules 

COPY package*.json .

RUN npm install

COPY . .

# EXPOSE 5173
ENV VITE_API_URL="http://localhost:5000"

# CMD [ "npm","run","build" ]
RUN npm run build

FROM httpd:alpine AS final

COPY --from=builder /home/app/frontend/dist /usr/local/apache2/htdocs/

# Copy a custom entrypoint script
# COPY entrypoint.sh /usr/local/bin/entrypoint.sh
# RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 80

# ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["httpd-foreground"]

