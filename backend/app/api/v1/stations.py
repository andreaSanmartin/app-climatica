"""Endpoints for Ecuadorian weather stations."""

from typing import List

from fastapi import APIRouter

from app.schemas.station_schema import Station
from app.services.station_service import get_stations

router = APIRouter(prefix="/stations", tags=["Stations"])


@router.get("", response_model=List[Station])
def read_stations() -> List[Station]:
    """Lista las estaciones de referencia de la red ecuatoriana (Guayaquil, Quito, Pastaza, Galápagos)."""
    return get_stations()
