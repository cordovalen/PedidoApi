#Usar imagen base de .NET 8 para construir
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

COPY . ./
RUN dotnet restore
RUN dotnet publish -c Release -o out

## Copia los archivos del proyecto y restaura las dependencias
#COPY PedidoApi.csproj ./
#RUN dotnet restore
#
## Copia todo el código fuente y publica la aplicación
#COPY . ./
#RUN dotnet publish -c Release -o out
#

FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app
COPY --from=build /app/out .

## Usa una imagen de runtime de .NET 8 para la imagen final
#FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS final
#WORKDIR /app
#COPY --from=build /app/out .
#
## Configura el puerto de escucha
#ENV ASPNETCORE_URLS=http://0.0.0.0:8080
#
## Expón el puerto
EXPOSE 5080
#
## Define el punto de entrada para el contenedor
ENTRYPOINT ["dotnet", "PedidoApi.dll"]
