"""Fetches current weather data from Open-Meteo."""

import requests
from fastapi import HTTPException

from app.core.config import settings
from app.schemas.weather_schema import WeatherResponse

CURRENT_FIELDS = ",".join([
    "temperature_2m",
    "relative_humidity_2m",
    "wind_speed_10m",
    "wind_direction_10m",
    "pressure_msl",
    "precipitation",
    "uv_index",
    "soil_moisture_3_to_9cm",
    "et0_fao_evapotranspiration",
])


def get_current_weather(lat: float, lon: float) -> WeatherResponse:
    """Consulta Open-Meteo y devuelve el clima actual para una coordenada."""
    params = {
        "latitude": lat,
        "longitude": lon,
        "current": CURRENT_FIELDS,
        "timezone": "auto",
    }

    try:
        response = requests.get(settings.OPEN_METEO_URL, params=params, timeout=settings.REQUEST_TIMEOUT)
        response.raise_for_status()
    except requests.RequestException as exc:
        raise HTTPException(status_code=502, detail=f"Error al consultar Open-Meteo: {exc}") from exc

    data = response.json()
    current = data.get("current")
    if not current:
        raise HTTPException(status_code=502, detail="Respuesta inválida de Open-Meteo")

    return WeatherResponse(
        latitude=lat,
        longitude=lon,
        temperature=current.get("temperature_2m"),
        humidity=current.get("relative_humidity_2m"),
        wind_speed=current.get("wind_speed_10m"),
        wind_direction=current.get("wind_direction_10m"),
        pressure=current.get("pressure_msl"),
        precipitation=current.get("precipitation"),
        uv_index=current.get("uv_index"),
        soil_moisture=current.get("soil_moisture_3_to_9cm"),
        evapotranspiration=current.get("et0_fao_evapotranspiration"),
        timezone=data.get("timezone"),
    )
