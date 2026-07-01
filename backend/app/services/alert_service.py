"""Generates basic weather alerts from current conditions."""

from typing import List

from app.schemas.alert_schema import Alert
from app.schemas.weather_schema import WeatherResponse
from app.services.weather_service import get_current_weather

RAIN_ALERT_MM = 4.0
UV_ALERT_INDEX = 8.0
WIND_ALERT_KMH = 40.0
HUMIDITY_HIGH_PERCENT = 90.0
HUMIDITY_LOW_PERCENT = 20.0


def build_alerts(weather: WeatherResponse) -> List[Alert]:
    alerts: List[Alert] = []

    if weather.precipitation is not None and weather.precipitation > RAIN_ALERT_MM:
        alerts.append(Alert(
            level="warning",
            title="Aviso hidrológico",
            message=(
                f"Precipitación de {weather.precipitation} mm detectada. "
                "Riesgo de acumulación de agua y crecidas en zonas bajas."
            ),
        ))

    if weather.uv_index is not None and weather.uv_index >= UV_ALERT_INDEX:
        alerts.append(Alert(
            level="critical",
            title="Radiación UV extrema",
            message=(
                f"Índice UV de {weather.uv_index}. Evite la exposición solar prolongada "
                "entre las 11:00 y las 15:00."
            ),
        ))

    if weather.wind_speed is not None and weather.wind_speed > WIND_ALERT_KMH:
        alerts.append(Alert(
            level="warning",
            title="Viento fuerte",
            message=f"Velocidad de viento de {weather.wind_speed} km/h. Asegure objetos sueltos y estructuras livianas.",
        ))

    if weather.humidity is not None and weather.humidity >= HUMIDITY_HIGH_PERCENT:
        alerts.append(Alert(
            level="info",
            title="Humedad muy alta",
            message=f"Humedad relativa de {weather.humidity}%. Posible sensación térmica elevada y formación de neblina.",
        ))
    elif weather.humidity is not None and weather.humidity <= HUMIDITY_LOW_PERCENT:
        alerts.append(Alert(
            level="info",
            title="Humedad muy baja",
            message=f"Humedad relativa de {weather.humidity}%. Riesgo de estrés hídrico en cultivos y vegetación.",
        ))

    if not alerts:
        alerts.append(Alert(
            level="info",
            title="Sin anomalías",
            message="Parámetros climáticos dentro de la media estacional. No se registran alertas activas.",
        ))

    return alerts


def get_alerts(lat: float, lon: float) -> List[Alert]:
    weather = get_current_weather(lat, lon)
    return build_alerts(weather)
