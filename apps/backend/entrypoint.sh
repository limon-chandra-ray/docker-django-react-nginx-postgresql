#!/bin/bash
echo "Waiting for postgres......."
sleep 5
echo "Postgres Started"

echo "Migrating Database ........."
/opt/venv/bin/python manage.py makemigrations --noinput
/opt/venv/bin/python manage.py migrate --noinput
echo "Database migrated"

echo "Created Superuser ......"
/opt/venv/bin/python manage.py superuser || true
echo "Superuser Created"


echo "Collecting static files......"
/opt/venv/bin/python manage.py collectstatic --noinput
echo "Static file Collected"

echo "Starting Gunicorn Server ......"
/opt/venv/bin/gunicorn backend.wsgi:application --bind "0.0.0.0:8000" --workers 4 