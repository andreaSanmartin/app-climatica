"""Static catalog of Ecuadorian weather stations (INAMHI network reference points)."""

from typing import List

from app.schemas.station_schema import Station

STATIONS: List[Station] = [
    Station(
        name="Guayaquil",
        region="Costa / Pacífico",
        latitude=-2.1811,
        longitude=-79.8860,
        description="Estación del litoral guayasense, sensible a anomalías térmicas oceánicas (El Niño/ENSO).",
    ),
    Station(
        name="Quito",
        region="Sierra Interandina",
        latitude=-0.1892,
        longitude=-78.4891,
        description="Estación Iñaquito en el callejón interandino, con alta exposición a radiación UV.",
    ),
    Station(
        name="Pastaza",
        region="Amazonía Pluvial",
        latitude=-1.4912,
        longitude=-77.9921,
        description="Nodo amazónico oriental, propenso a precipitaciones intensas y crecidas de ríos.",
    ),
    Station(
        name="Galápagos",
        region="Archipiélago",
        latitude=-0.7431,
        longitude=-90.3122,
        description="Estación insular en Santa Cruz, monitoreada por boyas NOAA para el fenómeno de El Niño.",
    ),
]


def get_stations() -> List[Station]:
    return STATIONS
