# Spring Batch Examples | DB And Async 

This project is a **Spring Boot** application demonstrating a **fully asynchronous Spring Batch job**, designed with a focus on **performance** and **scalability**.

---

## 🚀 Overview

The example showcases how to configure and run an **asynchronous Spring Batch job** that processes a large dataset efficiently.  
The job reads **10,000 records** from a database table, simulating item processing by printing  
`"item processed"` for each entry.

---

## ⚙️ How It Works

- The job leverages Spring Batch’s asynchronous capabilities to read and process data concurrently.
- An **H2 in-memory database** is used to store the sample data.
- The asynchronous behavior is enabled through a specific Spring profile.

---

## 🧩 Technologies Used

- **Java 21**
- **Spring Batch**
- **Spring Boot**
- **H2 Database**

---