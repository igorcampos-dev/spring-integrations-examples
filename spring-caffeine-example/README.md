# spring-caffeine-example

## Overview

This project is a simple and practical example demonstrating how to use **Caffeine** as an in-memory cache in a Spring Boot application.

The main goal is to show how Caffeine can be used to cache:
- external service calls (e.g. HTTP/Feign clients)
- database lookups

The project focuses on using **Caffeine directly**, avoiding unnecessary abstractions, to achieve better performance, predictability, and simplicity.

---

## Main Endpoint

| Environment | Curl                                                        |
|-------------|-------------------------------------------------------------|
| Local       | curl --location 'http://localhost:8080/caffeine/v1/request' |
| Docker      | curl --location 'http://localhost:7079/caffeine/v1/request' |

---

## Related Resources

| Description              | Link                                           |
|--------------------------|------------------------------------------------|
| Caffeine Github          | https://github.com/ben-manes/caffeine          |
| Introduction to Caffeine | https://www.baeldung.com/java-caching-caffeine |
