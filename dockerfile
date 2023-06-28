# Start from a base image
FROM python:3.10

# Set the working directory
WORKDIR /app

# Copy the requirements file into the container
COPY requirements.txt requirements.txt

# Install the required packages
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# Copy the application code into the container
COPY ["modelsss5.pkl", "app.py", "./"] .

# Expose the app port
EXPOSE 5000

# Run command
CMD ["uvicorn", "app:app", "--host", "localhost", "--port", "5000"]