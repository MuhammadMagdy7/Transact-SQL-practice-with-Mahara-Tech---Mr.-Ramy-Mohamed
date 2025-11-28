# Transact-SQL Labs – Course Companion

## Course Description
SQL developers are in high demand across healthcare, retail, finance, and more. Over the next 4–5 years, nearly every organization will rely on professionals who can interrogate and shape data with SQL. This course starts with SQL fundamentals—querying, filtering, sorting, aggregating, and joining—and then dives into Transact-SQL (T-SQL) so you can leverage SQL Server–specific features. The Transact SQL labs in this folder turn theory into practice through focused exercises that build confidence with real-world tasks.

## What You Will Learn
- Understand foundational Structured Query Language (SQL) concepts.
- Design relational databases using both GUI tools and T-SQL scripts.
- Create, manipulate, and retrieve data with robust SQL statements.
- Control result sets with `WHERE`, `ORDER BY`, and pattern matching via `LIKE`.
- Join multiple tables and craft complex queries to answer business questions.
- Pick optimal SQL datatypes to balance storage and performance.
- Manage identity columns safely across environments.
- Distinguish `DROP`, `DELETE`, and `TRUNCATE` statements.
- Enforce update/delete rules to protect referential integrity.
- Apply SQL Server built-in functions for calculations and transformations.
- Write subqueries for dynamic filtering or computation.
- Combine result sets using `UNION`, `INTERSECT`, and `EXCEPT`.
- Model solutions with Enhanced Entity-Relationship Diagrams (EERD).
- Administer SQL Server security and user access.
- Execute set-based DML with `TOP` and `MERGE`.
- Use ranking/window functions and advanced grouping (`ROLLUP`, `CUBE`, `GROUPING SETS`).
- Transform data with `PIVOT` and `UNPIVOT` for reporting scenarios.

## Requirements
- Completion of the Database Fundamentals course (or equivalent experience).
- SQL Server 2019+ with SQL Server Management Studio (SSMS) or Azure Data Studio.
- Sample backup files located in the repository root: `AdventureWorks2012.bak`, `Company DB.bak`, `ITI DB.bak`.

## Folder Layout
```
Transact SQL/
  Assignment1/
    Lab01.sql
    Lab01_DB Creation.doc.pdf
    Screenshot ...png
  Assignment2/
    Lab02.sql
    Lab02_Joins.doc.pdf
  Assignment3/
    Lab03.sql
    Lab03_Grouping.docx.pdf
  Assignment4/
    Lab04.sql
    Lab04_T-SQL.docx.pdf
```

| Lab | Focus | Key Assets |
| --- | --- | --- |
| `Assignment1` | Database creation fundamentals | `Lab01.sql`, walkthrough PDF, environment screenshot |
| `Assignment2` | Join strategies and querying multiple tables | `Lab02.sql`, joins lab brief |
| `Assignment3` | Aggregations and grouping techniques | `Lab03.sql`, grouping lab brief |
| `Assignment4` | Advanced T-SQL constructs and reusable scripts | `Lab04.sql`, advanced T-SQL brief |

## How to Work Through the Labs
1. **Restore sample databases** (`AdventureWorks2012`, `Company DB`, `ITI DB`) in SSMS: `Tasks > Restore > Database` pointing to the included `.bak` files.
2. **Read the PDF brief** inside each assignment folder to understand the scenario, objectives, and deliverables.
3. **Open the matching `.sql` file** in SSMS/Azure Data Studio. Execute statements incrementally to observe changes.
4. **Document outcomes** with notes or screenshots when required by the lab instructions.
5. **Iterate** by modifying queries: test alternative joins, filters, or window functions to deepen understanding.

## Suggested Progress Tracker
- [ ] Restore all provided sample databases.
- [ ] Finish `Lab01` (database creation basics).
- [ ] Finish `Lab02` (joins and multi-table queries).
- [ ] Finish `Lab03` (grouping and aggregation patterns).
- [ ] Finish `Lab04` (advanced T-SQL operations).

Mastering these labs ensures you can quickly apply SQL Server skills to production workloads, troubleshoot performance issues, and communicate insights backed by clean, reliable data.
