FROM owasp/modsecurity-crs:nginx

COPY conf/nginx.conf /etc/nginx/nginx.conf
COPY conf/modsecurity.conf /etc/modsecurity/modsecurity.conf
COPY conf/crs-setup.conf /etc/modsecurity/crs-setup.conf

EXPOSE 8080 8443

CMD ["nginx", "-g", "daemon off"]
