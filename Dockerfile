# Pull Dotnet image to build the project
FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build
ADD . /Build
WORKDIR /Build
RUN dotnet publish src/Services/HelloWorld/HelloWorld.csproj -c Release
    # dotnet publish src/Services/Journey/Journey.csproj -c Release

# Build the final NWN server image
FROM index.docker.io/nwndotnet/nwn.managed:636242b
LABEL maintainer="urothis"
# install our services
COPY --from=build /Build/src/Services/HelloWorld/bin/Release/Plugins/ /nwn/nwnm/Plugins/
#COPY --from=build /Build/src/Services/Journey/bin/Release/Plugins/ /nwn/nwnm/Plugins/
ENV NWN_SERVERNAME=TestingModuleName \
    NWN_MODULE=DockerDemo \
    NWN_PUBLICSERVER=0 \
    NWN_AUTOSAVEINTERVAL=0 \
    NWN_DIFFICULTY=3 \
    NWN_ELC=1 \
    NWN_GAMETYPE=0
    # add more env down here
