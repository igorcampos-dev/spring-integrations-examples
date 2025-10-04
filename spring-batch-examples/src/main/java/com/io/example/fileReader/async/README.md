# PENDING

# Spring Batch Examples | Async CSV Processing

This project is a **Spring Boot** application demonstrating a **fully asynchronous Spring Batch job**, designed with a focus on **performance** and **scalability**.

---

## 🚀 Overview

The example showcases how to configure and run an **asynchronous Spring Batch job** that processes a single CSV file efficiently.
The job reads **one CSV file**, simulating item processing by printing
`"item processed"` for each entry.

---

## ⚙️ How It Works

* The job leverages Spring Batch’s **asynchronous capabilities** to process data efficiently.
* A **CSV file** is used as the input data source.
* The asynchronous execution is enabled through a specific Spring profile.

---

## 🧩 Technologies Used

* **Java 21**
* **Spring Batch**
* **Spring Boot**
* **CSV file**

---

## ▶️ Running the Project

To run the asynchronous batch job processing a CSV file, simply activate the `asyncCsvReader` profile:

```bash
./mvnw spring-boot:run -Dspring-boot.run.profiles=asyncFileReader
```
