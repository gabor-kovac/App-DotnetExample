# Use the official .NET SDK image to build the app (Alpine)
FROM mcr.microsoft.com/dotnet/sdk:8.0-alpine AS build
WORKDIR /src

ARG NUGET_TOKEN

# Copy source code
COPY Source/ .
RUN dotnet nuget add source https://nuget.pkg.github.com/gabor-kovac/index.json --name github --username docker --password $NUGET_TOKEN --store-password-in-clear-text
RUN dotnet restore "App-DotnetExample.sln"

# Build the application
RUN dotnet publish "App-DotnetExample/App-DotnetExample.csproj" -c Release -o /app/publish

# Final stage/image
FROM mcr.microsoft.com/dotnet/aspnet:8.0-alpine AS final
WORKDIR /app
COPY --from=build /app/publish .

# Set the entry point
ENTRYPOINT ["dotnet", "App-DotnetExample.dll"]