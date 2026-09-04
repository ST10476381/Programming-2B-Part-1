# Programming-2B-Part-1
System Learning and Database
# RaceDay

RaceDay is a full-stack, web-based event management system built for the South African road running, walking, and cycling community. It replaces the paper-based registration, spreadsheets, and disconnected communication that many local events still rely on, giving organisers a central platform to manage events and giving participants an easy way to enter races and track their own results.

This is an individual project (module: PROG6212 - Programming 2B) built progressively across three parts. By the final submission it will be a fully containerised, cloud-aware, API-driven platform reflecting real-world software development practices used in the sports technology industry.

## Roles

- **Organiser** - creates and manages events, defines categories for each event, and captures results once a race has taken place.
- **Participant** - browses upcoming events, enrols in categories, tracks their personal enrolment and results history, and checks event details ahead of race day.

## Repository structure

```
/docs
  RaceDay_ERD.png / RaceDay_ERD.pdf     - Entity Relationship Diagram (Section A)
  RaceDay_API_Endpoint_Plan.pdf         - API endpoint plan (Section B)
  RaceDay_Schema.sql                    - Database schema + seed data (Section C)
.github/workflows
  ci.yml                                - CI workflow validating repo structure
README.md                               - This file
```

## Database

The database is built around six core entities: `Organiser`, `Participant`, `Event`, `Category`, `Enrolment`, and `Result`. Full details, including primary keys, foreign keys, and cardinality, are documented in the ERD and implemented in `RaceDay_Schema.sql`.

## Setup notes

1. Run `RaceDay_Schema.sql` in SQL Server Management Studio (SSMS). It creates the `RaceDay` database if it does not already exist, builds all tables and constraints, and seeds sample data.
2. See `RaceDay_API_Endpoint_Plan.pdf` for the full list of planned API endpoints, request/response formats, and role requirements.

## Submission

GitHub repository link submitted via ARC for each part, per module requirements.
