# EcoBali API

Backend en **Python + FastAPI** para EcoBali, plataforma de monitoreo climático para Ecuador. Expone datos meteorológicos, estaciones de referencia, alertas y recomendaciones para ser consumidos por la app móvil en Flutter.

## Estructura del proyecto

```
backend/
├── app/
│   ├── api/
│   │   └── v1/
│   │       ├── weather.py           # GET /api/v1/weather/current
│   │       ├── stations.py          # GET /api/v1/stations
│   │       ├── alerts.py            # GET /api/v1/alerts
│   │       └── recommendations.py   # GET /api/v1/recommendations
│   ├── core/
│   │   └── config.py                # Configuración vía variables de entorno
│   ├── models/                      # Reservado para futuros modelos de base de datos
│   ├── schemas/                     # Modelos Pydantic de request/response
│   ├── services/                    # Lógica de negocio y consumo de APIs externas
│   ├── utils/                       # Funciones auxiliares
│   └── main.py                      # Punto de entrada de la aplicación
├── requirements.txt
├── .env
├── .gitignore
└── README.md
```

## Requisitos

- Python 3.10+

## Instalación

```bash
cd backend
python -m venv .venv
.venv\Scripts\activate      # Windows
# source .venv/bin/activate # Linux / Mac

pip install -r requirements.txt
```

## Ejecución

```bash
uvicorn app.main:app --reload
```

La API estará disponible en `http://localhost:8000` y la documentación interactiva en `http://localhost:8000/docs`.

## Endpoints

| Método | Ruta                              | Descripción                                              |
|--------|------------------------------------|------------------------------------------------------------|
| GET    | `/`                                 | Estado de la API                                            |
| GET    | `/api/v1/weather/current?lat=&lon=` | Clima actual (Open-Meteo): temperatura, humedad, viento, presión, precipitación, UV y humedad del suelo |
| GET    | `/api/v1/stations`                  | Estaciones de referencia en Ecuador (Guayaquil, Quito, Pastaza, Galápagos) |
| GET    | `/api/v1/alerts?lat=&lon=`          | Alertas según precipitación, UV, viento y humedad          |
| GET    | `/api/v1/recommendations?lat=&lon=` | Recomendaciones agrícolas/ambientales                      |

## Fuentes de datos externas

- [Open-Meteo](https://open-meteo.com/) — datos meteorológicos en tiempo real (consumido directamente por el backend).
- INAMHI, GEOGLOWS, FEWS NET y NOAA — referenciados como fuentes oficiales adicionales para futuras integraciones.

## Notas

- Aún no incluye base de datos ni autenticación (previsto para futuras fases).
- Configuración de CORS abierta (`CORS_ORIGINS=*` en `.env`) para que la app Flutter pueda consumir la API libremente en desarrollo.
