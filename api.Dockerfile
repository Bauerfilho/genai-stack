FROM langchain/langchain:1.0.0

WORKDIR /app

RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    software-properties-common \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .

RUN pip install --upgrade -r requirements.txt

COPY api.py .
COPY utils.py .
COPY chains.py .

HEALTHCHECK CMD ["curl", "--fail", "http://localhost:8504"]

ENTRYPOINT [ "uvicorn", "api:app", "--host", "0.0.0.0", "--port", "8504" ]
