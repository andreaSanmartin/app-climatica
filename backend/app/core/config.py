"""Application settings loaded from environment variables (.env)."""

from pydantic_settings import BaseSettings, SettingsConfigDict


class Settings(BaseSettings):
    # General
    PROJECT_NAME: str = "EcoBali API"
    API_V1_PREFIX: str = "/api/v1"

    # CORS - comma separated list of allowed origins, "*" allows every origin
    CORS_ORIGINS: str = "*"

    # External APIs
    OPEN_METEO_URL: str = "https://api.open-meteo.com/v1/forecast"
    REQUEST_TIMEOUT: int = 10

    model_config = SettingsConfigDict(env_file=".env", env_file_encoding="utf-8")

    @property
    def cors_origins_list(self) -> list[str]:
        if self.CORS_ORIGINS.strip() == "*":
            return ["*"]
        return [origin.strip() for origin in self.CORS_ORIGINS.split(",")]


settings = Settings()
