
# RaceDay

RaceDay is a full-stack, web-based event management system built for the South African road running, walking, and cycling community. It replaces the paper-based registration, spreadsheets, and disconnected communication that many local events still rely on, giving organisers a central platform to manage events and giving participants an easy way to enter races and track their own results.

This is an individual project (module: PROG6212 - Programming 2B) built progressively across three parts. By the final submission it will be a fully containerised, cloud-aware, API-driven platform reflecting real-world software development practices used in the sports technology industry.

## Roles
RaceDay is built around two types of users, each with a different job to do.

Organisers are the clubs, race committees, and event companies who actually put these races on. They create events on the platform, break each one down into categories (say, a 5km fun run and a 21km alongside it), and set the entry fee and participant cap for each. Once race day has come and gone, they're also the ones who capture the results. An organiser only has control over the events they themselves created — they can't touch anyone else's.

Participants are the runners and cyclists who take part. They can browse events without needing an account, but once they've registered they can enrol in a category, keep track of the races they've entered, and look back over their own results and times after each event. Like organisers, participants can only manage their own enrolments — not anyone else's.

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

## SCREENSHOT OF CI/CD PIPELINE
https://github.com/ST10476381/Programming-2B-Part-1/blob/main/Screenshot%20(94).png

