"""Endpoints for weather alerts."""

from fastapi import APIRouter, Query

from app.schemas.alert_schema import AlertsResponse
from app.services.alert_service import get_alerts

router = APIRouter(prefix="/alerts", tags=["Alerts"])


@router.get("", response_model=AlertsResponse)
def read_alerts(
    lat: float = Query(..., description="Latitud"),
    lon: float = Query(..., description="Longitud"),
) -> AlertsResponse:
    """Genera alertas básicas según precipitación, índice UV, viento y humedad."""
    alerts = get_alerts(lat, lon)
    return AlertsResponse(latitude=lat, longitude=lon, alerts=alerts)
