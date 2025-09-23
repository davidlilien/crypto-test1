# Image de base légère
FROM python:3.11-slim

# Installer quelques dépendances système utiles
RUN apt-get update && apt-get install -y \
    git build-essential \
    && rm -rf /var/lib/apt/lists/*

# Créer le dossier de travail
WORKDIR /app

COPY requirements.txt /app/requirements.txt
RUN pip install --no-cache-dir -r /app/requirements.txt || true

# Copier le reste du projet (y compris le notebook)
COPY . /app

# Exposer le port Voilà
EXPOSE 8866

# Lancer Voilà sur ton notebook
CMD ["voila", "--port=8866", "--no-browser", "--Voila.ip=0.0.0.0", "cryptos.ipynb"]