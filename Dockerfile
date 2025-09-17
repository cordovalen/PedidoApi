FROM --platform=linux/arm64 mcr.microsoft.com/dotnet/sdk:8.0 AS build-env
WORKDIR /app

COPY . ./
RUN dotnet restore
RUN dotnet publish -c Release -o ./out --self-contained true --runtime linux-arm64 --framework net8.0 /p:RuntimeFrameworkVersion=8.0.0

FROM --platform=linux/arm64 mcr.microsoft.com/dotnet/sdk:8.0 AS base
WORKDIR /app
COPY --from=build-env /app/out .
EXPOSE 5000

ENTRYPOINT ["dotnet", "PedidoApi.dll"]
