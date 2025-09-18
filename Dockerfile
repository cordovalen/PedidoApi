FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build-env
WORKDIR /app

COPY . ./
RUN dotnet restore
RUN dotnet publish -c Release -o out

FROM mcr.microsoft.com/aspnet/sdk:8.0 AS runtime
WORKDIR /app
COPY --from=build-env /app/out .
EXPOSE 5000

ENTRYPOINT ["dotnet", "PedidoApi.dll"]
