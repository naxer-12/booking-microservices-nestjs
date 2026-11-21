#!/bin/bash
set -e

echo "Initializing multi-database environment..."

# Automatically create an isolated database for each microservice inside the single engine
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
  CREATE DATABASE identity;
  CREATE DATABASE flight;
  CREATE DATABASE passenger;
  CREATE DATABASE booking;
EOSQL

echo "All microservice databases initialized successfully!"