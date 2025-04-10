# Use an official Python runtime as a parent image
FROM python:3.11.10-slim

# Set the working directory in the container
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY ./src /app
COPY pyproject.toml /app
COPY poetry.lock /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
RUN pip install --no-cache-dir poetry
RUN poetry config virtualenvs.create false
RUN poetry lock
RUN poetry install --without dev
# RUN poetry run pip install dspy==2.6.2

# Set environment variables
ENV PYTHONUNBUFFERED=1
ENV PYTHONPATH=/app


# Expose the port the app runs on
EXPOSE 8080

# Run the application 
CMD ["poetry", "run", "uvicorn", "app:app", "--workers", "2", "--host", "0.0.0.0", "--port", "8080"]