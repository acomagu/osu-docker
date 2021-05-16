FROM mcr.microsoft.com/dotnet/core/sdk:2.2 AS build
WORKDIR /app
RUN wget https://github.com/ppy/osu/archive/master.zip && \
    unzip master.zip
RUN dotnet publish osu.Desktop -c Release -o osu -r linux-musl-x64 --self-contained true

FROM mcr.microsoft.com/dotnet/core/runtime-deps:2.1-alpine
WORKDIR /app
COPY --from=build /app/osu.Desktop/osu ./
ENTRYPOINT ["./osu"]
