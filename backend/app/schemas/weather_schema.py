"""Schemas for current weather data."""

from typing import Optional

from pydantic import BaseModel, Field


class WeatherResponse(BaseModel):
    latitude: float
    longitude: float
    temperature: Optional[float] = Field(None, description="Temperatura del aire en °C")
    humidity: Optional[float] = Field(None, description="Humedad relativa en %")
    wind_speed: Optional[float] = Field(None, description="Velocidad del viento en km/h")
    wind_direction: Optional[float] = Field(None, description="Dirección del viento en grados")
    pressure: Optional[float] = Field(None, description="Presión atmosférica a nivel del mar en hPa")
    precipitation: Optional[float] = Field(None, description="Precipitación en mm")
    uv_index: Optional[float] = Field(None, description="Índice UV")
    soil_moisture: Optional[float] = Field(None, description="Humedad del suelo en m³/m³, si está disponible")
    evapotranspiration: Optional[float] = Field(None, description="Evapotranspiración de referencia en mm")
    timezone: Optional[str] = None
