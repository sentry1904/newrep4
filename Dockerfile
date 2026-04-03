# Use official Python image
FROM python:3.10-slim

# Set working directory
WORKDIR /app

# Copy requirements (if you have one)
COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt

# Copy the app code
COPY . .

# Expose Flask default port
EXPOSE 5000

# Run the app
CMD ["python", "newapp.py"]

