FROM python:3

WORKDIR /data

# Copy the requirements file first to leverage Docker caching
COPY requirements.txt .

# Install dependencies
RUN pip install -r requirements.txt

# Copy the rest of the application code
COPY . .

# Run migrations
RUN python manage.py migrate

# Expose port 8000
EXPOSE 8000

# Start the Django application
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
