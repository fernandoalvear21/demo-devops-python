FROM python:3.11.3-slim
WORKDIR /app
RUN apt-get update && \
    apt-get install -y curl
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY . .
RUN useradd -m devopsuser && \
    chown -R devopsuser:devopsuser /app
USER devopsuser
EXPOSE 8000
HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 CMD curl -f http://localhost:8000/api/ || exit 1
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]