#!/bin/bash

# Wait until PostgreSQL is ready

echo "Waiting for PostgreSQL to be ready..."
sleep 5


# Run the migrations
bin/rails db:create
bin/rails db:migrate
bin/rails db:seed

# Optionally, you can add other initialization tasks here

# Exit the script
echo "Database migrations completed."
