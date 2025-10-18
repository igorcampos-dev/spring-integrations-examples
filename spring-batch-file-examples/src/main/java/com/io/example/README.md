# File Reading Examples \| Multi-format Processing

This project is a Spring Boot module that demonstrates basic, configurable setups for reading and processing different file formats using Spring batch. The examples are intentionally generic and meant to illustrate common configuration patterns, extension points, and how to plug different file readers into a batch processing pipeline.

---

## Overview

- Purpose: provide foundational configurations and examples for reading files of various formats.
- Goal: show how to configure readers, processors, and batch steps in a reusable way that can be adapted to different file types and processing requirements.

---

## Scope

This module focuses on demonstrating basic reader configurations and integration points. Use this section to list which file types are supported by this module:

- Excel \(.xlsx\) — reading implemented
- CSV \(.csv\) — next/planned

---

## How It Works (Generic)

- Uses Spring Batch for job and step orchestration.
- Provides example reader beans and mapping strategies for different file formats.
- Demonstrates how to enable/disable features via Spring profiles and configuration properties.
- Designed for extensibility so additional file readers can be added with minimal changes.

---

## Technologies Used

- Java 21
- Spring Boot
- Spring Batch

---