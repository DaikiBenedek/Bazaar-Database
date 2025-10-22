# 🐱 La Gatita Emprendedora — Database Project

## 📁 Repository Structure

```bash
├── Diagramas/                              # Database design diagrams
│   ├── ERLos_Piolines.drawio               # Entity-Relationship diagram (editable)
│   ├── ERLos_Piolines.png                  # Entity-Relationship diagram (image)
│   ├── RelacionalLos_Piolines.drawio       # Relational model diagram (editable)
│   └── RelacionalLos_Piolines.png          # Relational model diagram (image)
│
├── SQL/                                    # SQL scripts and database logic
│   ├── .DS_Store                           # (System file, may be ignored)
│   ├── DDL.sql                             # Database schema (tables, constraints, relationships)
│   ├── DML.sql                             # Data population script (sample records)
│   ├── Query.sql                           # Collection of example queries
│   └── SP_Triggers.sql                     # Stored procedures and triggers
│
├── LICENSE                                 # MIT License
├── ProyectoFinal_Reporte.pdf               # Full project report (documentation, models, analysis)
└── README.md                               # Project description and setup instructions
```

## 📘 Overview

This project was developed as the Final Project for the **Database Fundamentals** course at the Facultad de Ciencias, Universidad Nacional Autónoma de México (UNAM).

The project consists of the design and implementation of a **PostgreSQL relational database** for the fictional bazaar **“La Gatita Emprendedora”**, aiming to centralize information management and replace physical records with a structured digital solution.

## 🎯 Objective

The goal of this project is to design and implement a complete database system that models all entities and relationships of the bazaar, allowing efficient data storage, queries, and maintenance.

## 🧩 Project Components

This project includes the following stages and deliverables:

1. **Entity–Relationship (E-R) Model:** Conceptual design of entities and relationships.

2. **Relational Model:** Logical translation of the E-R model into relational tables.

3. **Physical Model:** Implementation in **PostgreSQL** with domain constraints, primary and foreign keys.

4. **Stored Procedures and Triggers:** Implementation of business logic at the database level.

5. **Data Population:** Sample data generation using **Mockaroo**.

6. **SQL Queries:** A collection of analytical and operational queries.

7. **Execution Guide:** Step-by-step instructions to set up and test the database using Docker and PostgreSQL.

## ⚙️ Main Features

- **Database Engine:** PostgreSQL

- **Containerization:** Docker

- **Data generation:** Mockaroo

- **Includes:** DDL, DML, Stored Procedures, Triggers, and SQL Queries

## 🗂️ Core Entities

- **Bazar:** Represents the event and its logistics (location, duration, amenities).

- **Estand (Stand):** Represents business stands with pricing packages (Basic, Premium, Entrepreneur).

- **Negocio (Business):** Each business participating in the bazaar.

- **Emprendedor (Entrepreneur):** Business owners or supervisors.

- **Cliente (Client):** Visitors who attend or buy at the bazaar.

- **Mercancía (Merchandise):** Products and services offered, including perishable and non-perishable goods.

- **Personal (Staff):** Includes medical, security, and cleaning staff.

- **Método de Pago (Payment Method):** Supports cash and card payments.

- **Ticket:** Purchase receipts linked to clients and entrepreneurs.

## 🛠️ Setup & Execution Guide

### Requirements

- Docker Desktop

- PostgreSQL CLI (psql)

- DDL.sql and DML.sql files (included in this repository)

### Steps to Run

1. Start Docker Desktop.

2. Create and run a PostgreSQL container:

```bash
docker run -d --name gatita-db -e POSTGRES_PASSWORD=gatitaEmp -p 5432:5432 postgres
```

3. Access the PostgreSQL container:
   
```bash
docker exec -it gatita-db psql -U postgres
```

4. Create and connect to the database:
   
```bash
CREATE DATABASE proyectogatita;
\c proyectogatita
```

5. Copy the SQL scripts into the container:
   
```bash
docker cp ./DDL.sql gatita-db:/DDL.sql
docker cp ./DML.sql gatita-db:/DML.sql
```

6. Execute the scripts:
    
```bash
docker exec -it gatita-db psql -U postgres -d proyectogatita -f /DDL.sql
docker exec -it gatita-db psql -U postgres -d proyectogatita -f /DML.sql
```

7. Load procedures, triggers, and run queries as described in the documentation.
   
8. Run example queries to verify data consistency and functionality.

📊 Example Queries

The project includes over 30 SQL queries, such as:

- Registered bazaars and their locations

- Top-selling products

- Entrepreneurs with multiple contact methods

- Businesses participating in multiple bazaars

- Revenue reports by payment type

👥 Team Members

- Daiki Benedek Rueda Tokuhara

- Moisés Abraham Lira Rivera

- Juan Luis Peña Mata

- Marco Flores Cid

- Andrés Daniel López Molina

- Etni Sarai Castro Sierra

Professor: Gerardo Avilés Rosas

Teaching Assistants: Luis Enrique García Gómez, Ricardo Badillo Macías
