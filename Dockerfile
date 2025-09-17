FROM --platform=$BUILDPLATFORM mcr.microsoft.com/dotnet/sdk:8.0 AS build-env AS build
WORKDIR /app

COPY . ./
RUN dotnet restore
RUN dotnet publish -c Release -o ./out --self-contained true --runtime linux-arm64 --framework net8.0 /p:RuntimeFrameworkVersion=8.0.0

FROM FROM --platform=$BUILDPLATFORM mcr.microsoft.com/dotnet/sdk:8.0 AS build-env AS base
WORKDIR /app
COPY --from=build /app/out .
EXPOSE 5000

ENTRYPOINT ["dotnet", "PedidoApi.dll"]
