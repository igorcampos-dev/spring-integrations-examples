# PENDING

# Spring Batch Examples | Async CSV Processing

This project is a **Spring Boot** application demonstrating a **fully asynchronous and parallel Spring Batch job**, designed with a focus on **performance** and **scalability**.

---

## 🚀 Overview

The example showcases how to configure and run an **asynchronous Spring Batch job** that executes **multiple steps in parallel**, each processing a different CSV file efficiently.
The job reads **two separate CSV files**, simulating item processing by printing
`"item processed"` for each entry in both files.

---

## ⚙️ How It Works

* The job leverages Spring Batch’s **asynchronous and parallel capabilities** to execute multiple steps concurrently, processing each CSV file independently and efficiently.
* Two **CSV files** are used as input data sources.
* The parallel execution is enabled through a specific Spring profile.

---

## 🧩 Technologies Used

* **Java 21**
* **Spring Batch**
* **Spring Boot**
* **CSV files**

---

## ▶️ Running the Project

To run the asynchronous and parallel batch job processing multiple CSV files, simply activate the `asyncCsvReader` profile:

```bash
./mvnw spring-boot:run -Dspring-boot.run.profiles=asyncParallelFileReader
```
