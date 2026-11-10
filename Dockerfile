# Omni-Tools for Railway.
# Upstream (iib0011/omni-tools, image built from main after v0.7.0) serves the built site from stock nginx on a fixed
# port 80, which cannot follow Railway's injected PORT (the healthcheck dials it). This wrapper copies the built site
# out of the pinned upstream image and serves it from nginx bound to PORT on IPv4 and IPv6. It gzips the JavaScript and
# WebAssembly bundles (about 46 MB of assets uncompressed), caches content-hashed assets, answers /healthz and falls
# back to the app shell for client-side routes, as upstream's config does.
FROM iib0011/omni-tools@sha256:99e21d937dbe5ff86f00ac06ce17b5507a81911fa8d781f9b244b4067350e1a7 AS upstream

FROM nginx:1.30-alpine@sha256:583b7f2fce1cdb8da5ad5c39ebd3c33b98b87d493190e548bdee1fa8c619c311
COPY --from=upstream /usr/share/nginx/html /usr/share/nginx/html
RUN rm -f /usr/share/nginx/html/_redirects \
 && sed -i 's/application\/javascript.*js;/application\/javascript                js mjs;/' /etc/nginx/mime.types \
 && sed -i 's/^worker_processes.*/worker_processes 2;/' /etc/nginx/nginx.conf
COPY default.conf.template /etc/nginx/templates/default.conf.template
ENV PORT=8080
EXPOSE 8080
