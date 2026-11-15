# Salon Appointment Scheduler

An interactive Bash program that books salon appointments and stores them in a PostgreSQL database.

## How it works

1. The script lists the salon's services, read from the database, and asks which one you want.
2. An unknown choice shows the list again.
3. It asks for your phone number. If the number is new, it asks for your name and saves you as a customer.
4. It asks what time you would like, saves the appointment, and confirms it.

`examples.txt` shows sample sessions.

## Database

Three tables in a `salon` database:

- `services`: the services on offer
- `customers`: name and phone number
- `appointments`: links a customer and a service to a time

## Files

- `salon.sh`: the booking script.
- `salon.sql`: a dump that rebuilds the database.
- `examples.txt`: example input and output.

## Running it

Requires PostgreSQL with a `freecodecamp` user, which is how the course environment is set up.

```bash
psql -U postgres < salon.sql
```

```bash
./salon.sh
```

## Background

One of the five required projects for freeCodeCamp's Relational Database certification.
