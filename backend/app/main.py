from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

from app.api.v1 import alerts, recommendations, stations, weather
from app.core.config import settings

app = FastAPI(
    title=settings.PROJECT_NAME,
    description="Backend climático de EcoBali para Ecuador (Open-Meteo, INAMHI, NOAA)",
    version="1.0.0",
)

# CORS habilitado para que la app Flutter pueda consumir la API
app.add_middleware(
    CORSMiddleware,
    allow_origins=settings.cors_origins_list,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(weather.router, prefix=settings.API_V1_PREFIX)
app.include_router(stations.router, prefix=settings.API_V1_PREFIX)
app.include_router(alerts.router, prefix=settings.API_V1_PREFIX)
app.include_router(recommendations.router, prefix=settings.API_V1_PREFIX)


@app.get("/")
def home():
    return {
        "status": "OK",
        "message": "EcoBali API funcionando",
    }