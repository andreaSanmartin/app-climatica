"""Schemas for agricultural/environmental recommendations."""

from typing import List

from pydantic import BaseModel


class Recommendation(BaseModel):
    category: str  # "agriculture", "health" o "environment"
    message: str


class RecommendationsResponse(BaseModel):
    latitude: float
    longitude: float
    recommendations: List[Recommendation]
