"""Endpoints for agricultural/environmental recommendations."""

from fastapi import APIRouter, Query

from app.schemas.recommendation_schema import RecommendationsResponse
from app.services.recommendation_service import get_recommendations

router = APIRouter(prefix="/recommendations", tags=["Recommendations"])


@router.get("", response_model=RecommendationsResponse)
def read_recommendations(
    lat: float = Query(..., description="Latitud"),
    lon: float = Query(..., description="Longitud"),
) -> RecommendationsResponse:
    """Genera recomendaciones agrícolas y ambientales según los datos climáticos actuales."""
    recommendations = get_recommendations(lat, lon)
    return RecommendationsResponse(latitude=lat, longitude=lon, recommendations=recommendations)
