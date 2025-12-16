# spring-wolf-example

## Overview

This project demonstrates how to use **Spring Wolf** to document and expose asynchronous APIs built with Spring Boot.  
It includes examples of asynchronous communication using **Kafka**, and will later include **Google Pub/Sub** and **AWS SQS**.

Spring Wolf automatically generates an **AsyncAPI specification** and provides a UI to visualize producers, consumers,  
and message schemas in real time.

---

## Tech Stack

- Spring Boot
- Spring Wolf
- Java 21
- Docker
- Kafka (implemented)
- Google Pub/Sub (pending)
- AWS SQS (pending)

---

## Current Progress

| Tool / Integration | Status        | Notes                                  |
|--------------------|---------------|----------------------------------------|
| Kafka              | ✔ Implemented | Consumer + Producer examples completed |
| Google Pub/Sub     | ⏳ Pending     | Planned for future implementation      |
| AWS SQS            | ⏳ Pending     | Planned for future implementation      |

---

## Endpoints

| Environment | URL                                                            |
|-------------|----------------------------------------------------------------|
| Docker      | http://localhost:7075/springwolf/asyncapi-ui.html              |
| Local       | http://localhost:8080/springwolf/asyncapi-ui.html              |

---

## Related Resources

| Description               | Link                                                                          |
|---------------------------|-------------------------------------------------------------------------------|
| Spring Wolf Documentation | https://springwolf.dev                                                        |
| AsyncAPI Specification    | https://www.asyncapi.com                                                      |
| Spring Wolf Examples      | https://github.com/springwolf/springwolf-core/tree/master/springwolf-examples |
