TLS Certificates for Keycloak
These certificates were manually generated using the following command:

```bash
openssl req -x509 -newkey rsa:4096 -keyout tls.key -out tls.crt -days 365 -nodes \
  -subj "/CN=localhost"
```
