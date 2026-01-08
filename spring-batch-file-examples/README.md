# Spring Batch File Readers

This project is a **Spring Boot** application that demonstrates how to build **custom file readers using Spring Batch**, with a strong focus on **performance**, **scalability**, and **clean design**.

The main goal of this repository is to showcase **different strategies for reading files** depending on their size and characteristics, following **real-world batch processing patterns**.

---

## 🚀 Overview

The project currently provides **custom Spring Batch `ItemReader` implementations** for reading Excel files, using **different approaches for small and large files**:

- **Small Excel files**: loaded and processed entirely in memory
- **Large Excel files**: streamed row by row to minimize memory usage

The architecture is intentionally extensible, allowing additional file formats (such as **CSV**) to be added in the future without changing the core batch flow.

---

## 📂 Supported File Types

### ✅ Currently Implemented

- **Small Excel files (`.xlsx`)**
    - Suitable for files that fit comfortably in memory
    - Simple and fast processing

- **Large Excel files (`.xlsx`)**
    - Streaming-based reader
    - Designed for large datasets
    - Low memory footprint
    - Handles empty rows gracefully

### 🕒 Planned

- **CSV files**
- Other structured file formats (as needed)


---

## 🧩 Technologies Used

- **Java 21**
- **Spring Batch**
- **Spring Boot**
- **Apache POI (Streaming API)**
- **pjfanning**

---

## 🎯 Project Goals

- Demonstrate **production-ready Spring Batch readers**
- Show how to handle **large files efficiently**
- Provide clean, extensible examples without framework overengineering