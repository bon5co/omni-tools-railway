# omni-tools-railway

Wrapper image for the Railway template of [Omni-Tools](https://github.com/iib0011/omni-tools), the self-hosted collection of browser-based utilities (image, video, PDF, text, JSON, CSV, time and number tools) that process files locally in the browser.

Upstream's image (`iib0011/omni-tools`, built from main after v0.7.0, pinned by digest) serves the site from stock nginx on a fixed port 80, so it cannot follow Railway's injected `PORT`. This image copies the built site into `nginx:1.30-alpine`, which binds `PORT` on IPv4 and IPv6, gzips JavaScript and WebAssembly, caches content-hashed assets, answers `/healthz` and falls back to the app shell for client-side routes.

Image: `ghcr.io/bon5co/omni-tools-railway`. Omni-Tools is MIT licensed; see the upstream repository.
