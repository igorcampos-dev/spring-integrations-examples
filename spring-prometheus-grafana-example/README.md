# spring-prometheus-grafana-example

---

## Overview

This is a basic Java Spring project demonstrating how to integrate Prometheus and Grafana  
to collect and visualize application metrics from a Spring Boot application.  
Metrics are exposed via Spring Actuator and scraped by Prometheus, which are then displayed  
in customizable dashboards using Grafana.

---

## Tech stack

- Spring Boot
- Spring Actuator
- Java 21
- Prometheus (Docker)
- Grafana (Docker)

---

## Ports

| Service    | Local URL                                      | Username/Password |
|------------|------------------------------------------------|-------------------|
| Prometheus | [http://localhost:9090](http://localhost:9090) | n/a               |
| Grafana    | [http://localhost:3000](http://localhost:3000) | admin/admin       |

---

## Related Resources

| Description                                | Link                                                                                                                                                                        |
|--------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Basic config spring + grafana + prometheus | [monitoring-spring-boot-applications-with-prometheus-and-grafana](https://hidev.cc/tutoriais-praticos/2025/03/monitorando-aplicacoes-spring-boot-com-prometheus-e-grafana/) |
| Grafana Dashboards Spring boot             | [grafana.com/grafana/dashboards](https://grafana.com/grafana/dashboards/?search=spring+boot)                                                                                |

---

## Dashboards Configured

| Name                    | File Path                                      | Source                                                                                 |
|-------------------------|------------------------------------------------|----------------------------------------------------------------------------------------|
| Spring Boot JVM Metrics | `docker/dashboards/jvm-metrics-dashboard.json` | [Grafana Dashboard #4701](https://grafana.com/grafana/dashboards/4701-jvm-micrometer/) |

---
