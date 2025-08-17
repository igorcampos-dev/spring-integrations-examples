# spring-keycloak-example

---

## Overview

Basic Java Spring (Java 21) project demonstrating integration with **Keycloak** for authentication and authorization.  
Includes a minimal setup for running a Spring Boot application secured by Keycloak (via OAuth2/OpenID Connect), suitable for local development and testing.

---

## Tech stack

- Spring Boot
- Java 21
- Keycloak (Docker)

---

## Authentication Types Implemented

### OIDC (OpenID Connect) via Keycloak

- **Description:** Authentication using Keycloak as the OpenID Connect (OIDC) identity provider.

- **Port:** `8083`

- **Spring Profile:** `OIDC` (this profile active module 'oidcAuth')

- **Backup keycloak:** `oidc_auth_db_backup.sql`

- **User Credentials:**
    - Username: `oidc-user`
    - Password: `oidc-password`

- **Protected Route:** `/secured`

- **Realm:** `redirect-login-example`


---

## Related Resources

| Description                                                      | Link                                                                                                  |
|------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------|
| Running Keycloak in a container                                  | [keycloak.org/containers](https://www.keycloak.org/server/containers)                                 |
| Teaching how to set up Openid connect                            | [youtube/IW15Q68V50E](https://youtu.be/IW15Q68V50E?si=sJjvFoq8m0xL8xLn)                               |
| Discussion about healthcheck configuration in keycloak container | [gist.github.com/sarath-soman](https://gist.github.com/sarath-soman/5d9aec06953bbd0990c648605d4dba07) |
