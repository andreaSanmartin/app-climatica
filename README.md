# 🌦️ EcoBali - Plataforma de Monitoreo Climático

EcoBali es una plataforma orientada al monitoreo climático, consulta de información meteorológica y visualización de datos ambientales en tiempo real para Ecuador.

El proyecto estará compuesto por una aplicación móvil desarrollada en **Flutter** y un backend desarrollado en **Python (FastAPI)**, permitiendo una arquitectura escalable y preparada para futuras integraciones con servicios externos.

---

# Arquitectura del proyecto

```
app-climatica/
│
├── backend/                 # API REST desarrollada en Python
│   ├── app/
│   │   ├── routers/
│   │   ├── services/
│   │   ├── models/
│   │   ├── schemas/
│   │   ├── core/
│   │   └── main.py
│   │
│   ├── requirements.txt
│   └── README.md
│
├── mobile/
│   └── flutter_app/         # Aplicación Flutter
│
├── prototype/
│   └── codepen-original/    # Prototipo web recibido inicialmente
│
├── docs/                    # Documentación técnica
│
├── .gitignore
│
└── README.md
```

---

# Tecnologías

## Backend

* Python 3.12+
* FastAPI
* Uvicorn
* Requests
* Pydantic
* Python Dotenv

## Aplicación móvil

* Flutter
* Dart

## APIs externas

* Open-Meteo
* Meteoblue
* NOAA
* INAMHI
* GEOGLOWS
* FEWS NET

---

# Objetivos del proyecto

La aplicación permitirá:

* Consultar información climática en tiempo real.
* Obtener la ubicación GPS del dispositivo.
* Visualizar estaciones meteorológicas.
* Consultar humedad relativa.
* Consultar velocidad del viento.
* Consultar dirección del viento.
* Consultar presión atmosférica.
* Consultar índice UV.
* Consultar precipitaciones.
* Consultar humedad del suelo.
* Mostrar mapas satelitales.
* Emitir alertas meteorológicas.
* Mostrar recomendaciones para agricultura y gestión de riesgos.

---

# Estado del proyecto

Actualmente el proyecto se encuentra en fase de migración.

Se recibió un prototipo desarrollado en HTML, CSS y JavaScript (CodePen), el cual servirá únicamente como referencia visual para el desarrollo de la aplicación móvil en Flutter.

---

# Flujo de la aplicación

```
Flutter
      │
      ▼
FastAPI (Python)
      │
      ├──────── Open-Meteo
      ├──────── Meteoblue
      ├──────── NOAA
      ├──────── INAMHI
      ├──────── GEOGLOWS
      └──────── FEWS NET
```

---

# Configuración del Backend

## Crear entorno virtual

Windows

```bash
python -m venv venv
venv\Scripts\activate
```

Linux / Mac

```bash
python3 -m venv venv
source venv/bin/activate
```

Instalar dependencias

```bash
pip install -r requirements.txt
```

Ejecutar el servidor

```bash
uvicorn app.main:app --reload
```

La API estará disponible en:

```
http://localhost:8000
```

Swagger:

```
http://localhost:8000/docs
```

---

# Configuración de Flutter

Crear el proyecto

```bash
flutter create flutter_app
```

Ingresar al proyecto

```bash
cd flutter_app
```

Ejecutar

```bash
flutter run
```

---

# Control de versiones

Clonar el repositorio

```bash
git clone https://github.com/USUARIO/NOMBRE_REPOSITORIO.git
```

Crear una rama

```bash
git checkout -b feature/nueva-funcionalidad
```

Guardar cambios

```bash
git add .
git commit -m "Descripción del cambio"
git push origin feature/nueva-funcionalidad
```

---

# Próximas funcionalidades

* Sistema de autenticación.
* Historial de consultas.
* Notificaciones Push.
* Alertas meteorológicas.
* Modo Offline.
* Dashboard administrativo.
* Gestión de usuarios.
* Reportes climáticos.
* Integración con sensores IoT.
* Exportación de datos.
* Mapas interactivos.
* Configuración personalizada de estaciones.

---

# Licencia

Proyecto privado.

Todos los derechos reservados.
