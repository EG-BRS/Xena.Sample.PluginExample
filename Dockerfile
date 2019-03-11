FROM microsoft/dotnet:2.1-sdk AS build-env
WORKDIR /app

# Copy csproj and restore as distinct layers
COPY src/*.csproj ./
RUN dotnet restore --no-cache --source https://api.nuget.org/v3/index.json --source https://www.myget.org/F/brs-nuget/auth/3f890ec8-f492-4c79-a23b-357f124dbeec/api/v2

# Copy everything else and build
COPY src/ ./
RUN dotnet publish -c Release -o out 

# Build runtime image
FROM microsoft/dotnet:2.1-aspnetcore-runtime
WORKDIR /app
COPY --from=build-env /app/out .
ENTRYPOINT ["dotnet", "Application.dll"]
