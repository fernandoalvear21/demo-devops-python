# Demo Devops Python

This is a simple application to be used in the technical test of DevOps.

## Getting Started

### Prerequisites

- Python 3.11.3
- Docker
- Kubernetes (Docker Desktop o Minikube)
- kubectl CLI

### Installation

Clone this repo.

```bash
git clone https://bitbucket.org/devsu/demo-devops-python.git
```

Install dependencies.

```bash
pip install -r requirements.txt
```

Migrate database

```bash
py manage.py makemigrations
py manage.py migrate
```

### Database

The database is generated as a file in the main path when the project is first run, and its name is `db.sqlite3`.

Consider giving access permissions to the file for proper functioning.

## Usage

To run tests you can use this command.

```bash
py manage.py test
```

To run locally the project you can use this command.

```bash
py manage.py runserver
```

Open http://localhost:8000/api/ with your browser to see the result.

### Features

These services can perform,

#### Create User

To create a user, the endpoint **/api/users/** must be consumed with the following parameters:

```bash
  Method: POST
```

```json
{
    "dni": "dni",
    "name": "name"
}
```

If the response is successful, the service will return an HTTP Status 200 and a message with the following structure:

```json
{
    "id": 1,
    "dni": "dni",
    "name": "name"
}
```

If the response is unsuccessful, we will receive status 400 and the following message:

```json
{
    "detail": "error"
}
```

#### Get Users

To get all users, the endpoint **/api/users** must be consumed with the following parameters:

```bash
  Method: GET
```

If the response is successful, the service will return an HTTP Status 200 and a message with the following structure:

```json
[
    {
        "id": 1,
        "dni": "dni",
        "name": "name"
    }
]
```

#### Get User

To get an user, the endpoint **/api/users/<id>** must be consumed with the following parameters:

```bash
  Method: GET
```

If the response is successful, the service will return an HTTP Status 200 and a message with the following structure:

```json
{
    "id": 1,
    "dni": "dni",
    "name": "name"
}
```

If the user id does not exist, we will receive status 404 and the following message:

```json
{
    "detail": "Not found."
}
```

## License

Copyright © 2023 Devsu. All rights reserved.

## DevOps Configuration

### Docker 🐳

#### Configuración del Contenedor
La aplicación está containerizada usando Docker con las siguientes características:

- **Imagen Base**: Python 3.11.3-slim
- **Seguridad**:
  - Usuario no-root (devopsuser)
  - Permisos mínimos necesarios
- **Monitoreo**:
  - Health checks cada 30 segundos
  - Verificación del endpoint /api/
- **Red**:
  - Puerto expuesto: 8000
  - Acceso via HTTP

#### Comandos Docker

**Construcción de la Imagen**:
```bash
# Construir la imagen localmente
docker build -t devsu-demo-python .

# Construir con tag específico
docker build -t tuusuario/devsu-demo-python:latest .
```

# Ejecutar el contenedor
docker run -p 8000:8000 devsu-demo-python

### Kubernetes 🚢

#### Configuración del Cluster
La aplicación está orquestada en Kubernetes con los siguientes componentes:

- **Deployment**:
  - 2 réplicas para alta disponibilidad
  - Rolling updates para actualizaciones sin tiempo de inactividad
  - Recursos limitados para optimización

- **Service**:
  - Tipo: LoadBalancer
  - Puerto: 8000
  - Balanceo de carga entre pods

- **ConfigMap**:
  - Variables de entorno no sensibles
  - Configuración de Django
  - Parámetros de la aplicación

- **Secret**:
  - Almacenamiento seguro de credenciales
  - DJANGO_SECRET_KEY codificada en base64
  - Gestión segura de datos sensibles

- **Ingress**:
  - Enrutamiento de tráfico HTTP
  - Punto de entrada único
  - Gestión de rutas

#### Comandos Kubernetes

**Despliegue de la Aplicación**:
```bash
# Aplicar todas las configuraciones
kubectl apply -f k8s/

# Verificar el estado de los pods
kubectl get pods

# Verificar servicios
kubectl get services
```

### Pipeline CI/CD 🚀

#### Configuración del Pipeline
El pipeline está implementado en GitHub Actions y consta de las siguientes etapas:

- **Build y Test**:
  - Instalación de dependencias de Python
  - Validación de la aplicación Django
  - Ejecución de pruebas unitarias
  - Análisis estático de código (pylint)
  - Reporte de cobertura de código

- **Docker**:
  - Login en Docker Hub
  - Construcción de imagen Docker
  - Push de la imagen a Docker Hub
  - Tagging con SHA del commit y latest

#### Protección de Ramas

- **Rama Principal (main)**:
  - Protegida contra push directo
  - Requiere Pull Request para cambios
  - Necesita 1 aprobación mínima
  - Los checks deben pasar antes del merge

#### Estructura del Pipeline
```yaml
name: Python application Production

on: 
  push:
    branches:
      - main
  pull_request:
    branches:
      - main

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - Checkout del código
      - Configuración de Python
      - Instalación de dependencias
      - Validación de Django
      - Pruebas unitarias
      - Análisis de código
      - Cobertura de código
      - Build y Push de Docker
```

### Diagrama de Arquitectura 📊
![Diagrama de Arquitectura](
  docs/project-diagram.png
)

