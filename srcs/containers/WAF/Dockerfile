FROM owasp/modsecurity-crs:nginx

USER root
RUN apt update && apt install -y vim
RUN mv etc/modsecurity.d etc/modsecurity

COPY conf/nginx.conf /etc/nginx/nginx.conf
COPY conf/modsecurity.conf /etc/modsecurity/owasp-crs/modsecurity.conf
COPY conf/crs-setup.conf /etc/modsecurity/owasp-crs/crs-setup.conf
COPY conf/rules/ etc/modsecurity/owasp-crs/rules/

EXPOSE 8080 8443

CMD ["nginx", "-g", "daemon off"]
#CMD ["sh", "-c", "cp -r $(pwd)conf/ data && nginx -g 'daemon off;'"]
