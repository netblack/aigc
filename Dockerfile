FROM polinux/mkdocs:1.1.2 as builder

WORKDIR /tmp

COPY mkdocs.yml /tmp
COPY docs /tmp/docs
RUN mkdocs build

FROM nginx:stable as prod

COPY --from=builder /tmp/site /usr/share/nginx/html
