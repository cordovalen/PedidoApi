FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS build-env
WORKDIR /app

COPY . ./
RUN dotnet restore
RUN dotnet publish -c Release -o ./out --self-contained true --runtime linux-arm64 --framework net8.0 /p:RuntimeFrameworkVersion=8.0.0

FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app
COPY --from=build-env /app/out .
EXPOSE 5000

ENTRYPOINT ["dotnet", "PedidoApi.dll"]
