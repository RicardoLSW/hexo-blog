FROM nginx
COPY nginx/default.conf /etc/nginx/conf.d/
RUN rm -rf /usr/share/nginx/html/*
RUN yarn build
COPY /dist /usr/share/nginx/html
CMD ["nginx", "-g", "daemon off;"]