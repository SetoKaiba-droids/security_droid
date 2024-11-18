FROM python:3.11-slim


# Set the working directory
WORKDIR /app

#docker build -f Dockerfile_a.dockerfile --mount=type=bind,source=./models,target=/app/models -t jarvis-piper .
#RUN --mount=type=bind,source=./models,target=/app/models
#ls -al /app/models
# Get the latest version of the code
RUN apt update && apt install -y git
RUN git clone https://github.com/rhasspy/piper

# Update pip and install the required packages
RUN pip install --upgrade pip

# Set the working directory
WORKDIR /app/piper/src/python_run

# Install the package
RUN pip install -e .

# Install the requirements
RUN pip install -r requirements.txt

# Install http server
RUN pip install -r requirements_http.txt

# Copy the folder of piper-voices/de into the container
#COPY 
# Expose the port 5000
EXPOSE 5005

# Run the webserver with python -m piper.http_server --model ...
#CMD ["python", "-m", "piper.http_server", "-m", "/app/models/en_GB-IR1-9499-medium.onnx", "--port", "5005", "--sentence_silence", "0.01"]
#CMD ["python", "-m", "piper.http_server", "-m", "/app/models/en_GB-IR1-9499-medium.onnx", "--port", "5008", "--sentence_silence", "0.01"]
CMD ["sh","-c","python -m piper.http_server -m  /app/models/en_GB-k2so-medium.onnx --port 5005 --sentence_silence 0.02"]