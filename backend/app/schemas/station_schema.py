"""Schemas for weather stations."""

from pydantic import BaseModel


class Station(BaseModel):
    name: str
    region: str
    latitude: float
    longitude: float
    description: str
