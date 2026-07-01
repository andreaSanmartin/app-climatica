"""Schemas for weather alerts."""

from typing import List

from pydantic import BaseModel


class Alert(BaseModel):
    level: str  # "info", "warning" o "critical"
    title: str
    message: str


class AlertsResponse(BaseModel):
    latitude: float
    longitude: float
    alerts: List[Alert]
