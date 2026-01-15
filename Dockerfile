# Stage 1: Build stage
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /source

# Копіюємо проект і відновлюємо залежності
COPY ["DockerTest1/DockerTest1.csproj", "DockerTest1/"]
RUN dotnet restore "DockerTest1/DockerTest1.csproj"

# Копіюємо всі файли і будуємо додаток
COPY . .
WORKDIR /source/DockerTest1
RUN dotnet publish -c Release -o /app

# Stage 2: Final image for runtime
FROM mcr.microsoft.com/dotnet/aspnet:9.0

WORKDIR /app

# Копіюємо додаток з етапу побудови
COPY --from=build /app .

# Запускаємо додаток
ENTRYPOINT ["dotnet", "DockerTest1.dll"]
