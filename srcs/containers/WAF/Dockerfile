FROM owasp/modsecurity-crs:nginx

USER root
RUN apt update && apt install -y vim
#RUN mv etc/modsecurity.d etc/modsecurity
RUN rm -rf etc/nginx/conf.d/default.conf
#RUN rm -rf etc/modsecurity.d/modsecurity-override.conf

COPY conf/nginx.conf /etc/nginx/nginx.conf
COPY conf/modsecurity.conf /etc/modsecurity.d/owasp-crs/modsecurity.conf
COPY conf/crs-setup.conf /etc/modsecurity.d/owasp-crs/crs-setup.conf
COPY conf/rules/ etc/modsecurity.d/owasp-crs/rules/

EXPOSE 8080 

CMD ["nginx", "-g", "daemon off"]
#CMD ["sh", "-c", "cp -r $(pwd)conf/ data && nginx -g 'daemon off;'"]
