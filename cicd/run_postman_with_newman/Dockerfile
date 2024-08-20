FROM postman/newman

LABEL maintainer="Roman Marcu <romanmarcu@gmail.com>"

RUN npm install -g newman-reporter-htmlextra
WORKDIR /etc/newman

ENTRYPOINT ["newman"]