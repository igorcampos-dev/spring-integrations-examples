# spring-jasper-example

---

## Overview

Basic Java Spring (Java 21) project demonstrating report generation with JasperReports.  
Includes loading `.jasper` templates, populating them with mock data, and exporting to PDF via a REST endpoint.

---

## Tech stack

- Spring Boot
- Java 21
- JasperReports

---

## Profiles you can activate

- **client-list-dev** – Used in Docker, in the future, it will use pre-compiled `.jasper` files instead of `.jrxml`. Activates the internal module that generates a simple client report.
- **client-list-local** – Used locally, activates the internal module that generates a simple client report and use `.jrxml`.

