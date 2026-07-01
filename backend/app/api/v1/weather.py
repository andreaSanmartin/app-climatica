"""Endpoints for current weather data."""

from fastapi import APIRouter, Query

from app.schemas.weather_schema import WeatherResponse
from app.services.weather_service import get_current_weather

router = APIRouter(prefix="/weather", tags=["Weather"])


@router.get("/current", response_model=WeatherResponse)
def read_current_weather(
    lat: float = Query(..., description="Latitud"),
    lon: float = Query(..., description="Longitud"),
) -> WeatherResponse:
    """Devuelve el clima actual para una coordenada dada, consumiendo Open-Meteo."""
    return get_current_weather(lat, lon)
