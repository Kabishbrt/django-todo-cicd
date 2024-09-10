# Use the official Python image from the Docker Hub
FROM python:3

# Set the working directory
WORKDIR /data

# Install python3-venv and other necessary packages
RUN apt-get update && apt-get install -y python3-venv

# Create a virtual environment
RUN python -m venv /opt/venv

# Upgrade pip within the virtual environment
RUN /opt/venv/bin/pip install --upgrade pip

# Copy the requirements file first to leverage Docker caching
COPY requirements.txt .

# Install dependencies in the virtual environment
RUN /opt/venv/bin/pip install -r requirements.txt

# Copy the rest of the application code
COPY . .

# Set environment variable to use the virtual environment
ENV PATH="/opt/venv/bin:$PATH"

# Run migrations
RUN python manage.py migrate

# Expose port 8000
EXPOSE 8000

# Start the Django application
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
