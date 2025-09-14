# Usa una imagen de SDK de .NET 8 para compilar la aplicación
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Copia los archivos del proyecto y restaura las dependencias
COPY PedidoApi.csproj ./
RUN dotnet restore

# Copia todo el código fuente y publica la aplicación
COPY . ./
RUN dotnet publish -c Release -o out

# Usa una imagen de runtime de .NET 8 para la imagen final
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS final
WORKDIR /app
COPY --from=build /app/out .

# Configura el puerto de escucha
ENV ASPNETCORE_URLS=http://localhost:5000

# Expón el puerto
EXPOSE 5000

# Define el punto de entrada para el contenedor
ENTRYPOINT ["dotnet", "PedidoApi.dll"]