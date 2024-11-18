@echo off

C:
cd \piper
timeout /t 60 /nobreak
powershell -Command "docker run --rm -d -v ${pwd}/models:/app/models -p 5005:5005/tcp k2so-piper:latest"


