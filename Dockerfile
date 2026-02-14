# Use a slim Python image
FROM python:3.11-slim

# Install uv
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

# Set working directory
WORKDIR /app

# Copy dependency files
COPY pyproject.toml uv.lock ./

# Install dependencies using uv
RUN uv sync --frozen --no-cache

# Copy the rest of the application
COPY . .

# Expose the port Render uses
EXPOSE 5000

# Run the application with gunicorn
CMD ["/app/.venv/bin/gunicorn", "--bind", "0.0.0.0:5000", "main:APP"]
