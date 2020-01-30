# Singularity Minecraft Server

## Installation/Configuration

1. Clone this repository

2. Install [Singularity](https://singularity.lbl.gov/install-linux)

3. Edit `MC_Server/server.properties` to your preferences

4. Edit `MC_Server/startServer.sh` to your preferences. Change 10 in `-Xmx10G` to change the max memory allocation for the server and the 1 in `-Xms1G` to change the minimum

5. Download the server jar file of the version you'd like from [mcversions.net](https://mcversions.net/), rename it to `server.jar` and put it in `MC_Server`

6. Run `sudo singularity build Singularity_MC.sif MC_Recipe` to build the container

## Running the Server

Run `./Singularity_MC.sif` to start the server.
