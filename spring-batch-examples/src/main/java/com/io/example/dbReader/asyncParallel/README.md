# Spring Batch Examples | DB And Async Parallel

This project is a **Spring Boot** application demonstrating a **fully asynchronous and parallel Spring Batch job**, designed with a focus on **performance** and **scalability**.

---

## 🚀 Overview

The example showcases how to configure and run an **asynchronous Spring Batch job** that executes **multiple steps in parallel**, processing a large dataset efficiently.
The job reads **10,000 records** from a database table, simulating item processing by printing
`"item processed"` for each entry.

---

## ⚙️ How It Works

* The job leverages Spring Batch’s **asynchronous and parallel capabilities** to execute multiple steps concurrently and process data efficiently.
* An **H2 in-memory database** is used to store the sample data.
* The parallel execution is enabled through a specific Spring profile.

---

## 🧩 Technologies Used

* **Java 21**
* **Spring Batch**
* **Spring Boot**
* **H2 Database**

---

## ▶️ Running the Project

To run the asynchronous and parallel batch job, simply activate the `asyncDbReader` profile:

```bash
./mvnw spring-boot:run -Dspring-boot.run.profiles=asyncParallelDbReader
```
