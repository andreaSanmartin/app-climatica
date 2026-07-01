"""Generates agricultural and environmental recommendations from current conditions."""

from typing import List

from app.schemas.recommendation_schema import Recommendation
from app.schemas.weather_schema import WeatherResponse
from app.services.alert_service import HUMIDITY_LOW_PERCENT, RAIN_ALERT_MM, UV_ALERT_INDEX, WIND_ALERT_KMH
from app.services.weather_service import get_current_weather


def build_recommendations(weather: WeatherResponse) -> List[Recommendation]:
    recs: List[Recommendation] = []

    if weather.precipitation is not None and weather.precipitation > RAIN_ALERT_MM:
        recs.append(Recommendation(
            category="agriculture",
            message="Suspenda riegos programados y revise drenajes de cultivos ante el exceso de lluvia.",
        ))
        recs.append(Recommendation(
            category="environment",
            message="Evite el cruce de ríos o vías anegadas hasta que baje el caudal.",
        ))

    if weather.uv_index is not None and weather.uv_index >= UV_ALERT_INDEX:
        recs.append(Recommendation(
            category="health",
            message="Use protector solar SPF 50+ y limite actividades al aire libre en horas de máxima radiación.",
        ))

    if weather.wind_speed is not None and weather.wind_speed > WIND_ALERT_KMH:
        recs.append(Recommendation(
            category="agriculture",
            message="Refuerce invernaderos, tutores y mallas de cultivo ante ráfagas fuertes de viento.",
        ))

    if weather.soil_moisture is not None and weather.soil_moisture < 0.20:
        recs.append(Recommendation(
            category="agriculture",
            message="Humedad del suelo baja: programe riego adicional para evitar estrés hídrico en cultivos.",
        ))

    if weather.humidity is not None and weather.humidity <= HUMIDITY_LOW_PERCENT:
        recs.append(Recommendation(
            category="environment",
            message="Ambiente seco: aumente el riego de áreas verdes y esté atento al riesgo de incendios forestales.",
        ))

    if not recs:
        recs.append(Recommendation(
            category="environment",
            message="Condiciones estables. Mantenga el monitoreo habitual de boletines climáticos de INAMHI.",
        ))

    return recs


def get_recommendations(lat: float, lon: float) -> List[Recommendation]:
    weather = get_current_weather(lat, lon)
    return build_recommendations(weather)
