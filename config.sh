#!/bin/bash

if [[ -z `which java` ]]; then
    # If the system is debian based
    if [[ -n `which apt` ]]; then 
        echo "Debian based system detected, installing dependencies with apt"
        sudo apt install openjdk-11-jre
    elif [[ -n `which pacman` ]]; then
        echo "Arch based system detected, installing dependencies with pacman"
        sudo pacman -S jre11-openjdk-headless
    else
        echo "Could not detect software manager. Dependencies will need to be installed automatically"
    fi
fi

echo "What server version would you like to use?"
serverJar="https://launcher.mojang.com/v1/objects/a412fd69db1f81db3f511c1463fd304675244077/server.jar"

declare -A versions
versions=( ["1.2.1"]="https://assets.minecraft.net/1_2/minecraft_server.jar"
        ["1.2.2"]="https://assets.minecraft.net/1_2/minecraft_server.jar"
        ["1.2.3"]="https://assets.minecraft.net/1_2/minecraft_server.jar"
        ["1.2.4"]="https://assets.minecraft.net/1_2_5/minecraft_server.jar"
        ["1.2.5"]="https://launcher.mojang.com/v1/objects/d8321edc9470e56b8ad5c67bbd16beba25843336/server.jar"
        ["1.3.1"]="https://launcher.mojang.com/v1/objects/82563ce498bfc1fc8a2cb5bf236f7da86a390646/server.jar"
        ["1.3.2"]="https://launcher.mojang.com/v1/objects/3de2ae6c488135596e073a9589842800c9f53bfe/server.jar"
        ["1.4.2"]="https://launcher.mojang.com/v1/objects/5be700523a729bb78ef99206fb480a63dcd09825/server.jar"
        ["1.4.4"]="https://launcher.mojang.com/v1/objects/4215dcadb706508bf9d6d64209a0080b9cee9e71/server.jar"
        ["1.4.5"]="https://launcher.mojang.com/v1/objects/c12fd88a8233d2c517dbc8196ba2ae855f4d36ea/server.jar"
        ["1.4.6"]="https://launcher.mojang.com/v1/objects/a0aeb5709af5f2c3058c1cf0dc6b110a7a61278c/server.jar"
        ["1.4.7"]="https://launcher.mojang.com/v1/objects/2f0ec8efddd2f2c674c77be9ddb370b727dec676/server.jar"
        ["1.5.1"]="https://launcher.mojang.com/v1/objects/d07c71ee2767dabb79fb32dad8162e1b854d5324/server.jar"
        ["1.5.2"]="https://launcher.mojang.com/v1/objects/f9ae3f651319151ce99a0bfad6b34fa16eb6775f/server.jar"
        ["1.6.1"]="https://launcher.mojang.com/v1/objects/0252918a5f9d47e3c6eb1dfec02134d1374a89b4/server.jar"
        ["1.6.2"]="https://launcher.mojang.com/v1/objects/01b6ea555c6978e6713e2a2dfd7fe19b1449ca54/server.jar"
        ["1.6.4"]="https://launcher.mojang.com/v1/objects/050f93c1f3fe9e2052398f7bd6aca10c63d64a87/server.jar"
        ["1.7.2"]="https://launcher.mojang.com/v1/objects/3716cac82982e7c2eb09f83028b555e9ea606002/server.jar"
        ["1.7.3"]="https://launcher.mojang.com/v1/objects/707857a7bc7bf54fe60d557cca71004c34aa07bb/server.jar"
        ["1.7.4"]="https://launcher.mojang.com/v1/objects/61220311cef80aecc4cd8afecd5f18ca6b9461ff/server.jar"
        ["1.7.5"]="https://launcher.mojang.com/v1/objects/e1d557b2e31ea881404e41b05ec15c810415e060/server.jar"
        ["1.7.6"]="https://launcher.mojang.com/v1/objects/41ea7757d4d7f74b95fc1ac20f919a8e521e910c/server.jar"
        ["1.7.7"]="https://launcher.mojang.com/v1/objects/a6ffc1624da980986c6cc12a1ddc79ab1b025c62/server.jar"
        ["1.7.8"]="https://launcher.mojang.com/v1/objects/c69ebfb84c2577661770371c4accdd5f87b8b21d/server.jar"
        ["1.7.9"]="https://launcher.mojang.com/v1/objects/4cec86a928ec171fdc0c6b40de2de102f21601b5/server.jar"
        ["1.7.10"]="https://launcher.mojang.com/v1/objects/952438ac4e01b4d115c5fc38f891710c4941df29/server.jar"
        ["1.8"]="https://launcher.mojang.com/v1/objects/a028f00e678ee5c6aef0e29656dca091b5df11c7/server.jar"
        ["1.8.1"]="https://launcher.mojang.com/v1/objects/68bfb524888f7c0ab939025e07e5de08843dac0f/server.jar"
        ["1.8.2"]="https://launcher.mojang.com/v1/objects/a37bdd5210137354ed1bfe3dac0a5b77fe08fe2e/server.jar"
        ["1.8.3"]="https://launcher.mojang.com/v1/objects/163ba351cb86f6390450bb2a67fafeb92b6c0f2f/server.jar"
        ["1.8.4"]="https://launcher.mojang.com/v1/objects/dd4b5eba1c79500390e0b0f45162fa70d38f8a3d/server.jar"
        ["1.8.5"]="https://launcher.mojang.com/v1/objects/ea6dd23658b167dbc0877015d1072cac21ab6eee/server.jar"
        ["1.8.6"]="https://launcher.mojang.com/v1/objects/2bd44b53198f143fb278f8bec3a505dad0beacd2/server.jar"
        ["1.8.7"]="https://launcher.mojang.com/v1/objects/35c59e16d1f3b751cd20b76b9b8a19045de363a9/server.jar"
        ["1.8.8"]="Thttps://launcher.mojang.com/v1/objects/5fafba3f58c40dc51b5c3ca72a98f62dfdae1db7/server.jarODO"
        ["1.8.9"]="https://launcher.mojang.com/v1/objects/b58b2ceb36e01bcd8dbf49c8fb66c55a9f0676cd/server.jar"
        ["1.9"]="https://launcher.mojang.com/v1/objects/b4d449cf2918e0f3bd8aa18954b916a4d1880f0d/server.jar"
        ["1.9.1"]="https://launcher.mojang.com/v1/objects/bf95d9118d9b4b827f524c878efd275125b56181/server.jar"
        ["1.9.2"]="https://launcher.mojang.com/v1/objects/2b95cc7b136017e064c46d04a5825fe4cfa1be30/server.jar"
        ["1.9.3"]="https://launcher.mojang.com/v1/objects/8e897b6b6d784f745332644f4d104f7a6e737ccf/server.jar"
        ["1.9.4"]="https://launcher.mojang.com/v1/objects/edbb7b1758af33d365bf835eb9d13de005b1e274/server.jar"
        ["1.10"]="https://launcher.mojang.com/v1/objects/a96617ffdf5dabbb718ab11a9a68e50545fc5bee/server.jar"
        ["1.10.1"]="https://launcher.mojang.com/v1/objects/cb4c6f9f51a845b09a8861cdbe0eea3ff6996dee/server.jar"
        ["1.10.2"]="https://launcher.mojang.com/v1/objects/3d501b23df53c548254f5e3f66492d178a48db63/server.jar"
        ["1.11"]="https://launcher.mojang.com/v1/objects/48820c84cb1ed502cb5b2fe23b8153d5e4fa61c0/server.jar"
        ["1.11.1"]="https://launcher.mojang.com/v1/objects/1f97bd101e508d7b52b3d6a7879223b000b5eba0/server.jar"
        ["1.11.2"]="https://launcher.mojang.com/v1/objects/f00c294a1576e03fddcac777c3cf4c7d404c4ba4/server.jar"
        ["1.12"]="https://launcher.mojang.com/v1/objects/8494e844e911ea0d63878f64da9dcc21f53a3463/server.jar"
        ["1.12.1"]="https://launcher.mojang.com/v1/objects/561c7b2d54bae80cc06b05d950633a9ac95da816/server.jar"
        ["1.12.2"]="https://launcher.mojang.com/v1/objects/886945bfb2b978778c3a0288fd7fab09d315b25f/server.jar"
        ["1.13"]="https://launcher.mojang.com/v1/objects/d0caafb8438ebd206f99930cfaecfa6c9a13dca0/server.jar"
        ["1.13.1"]="https://launcher.mojang.com/v1/objects/fe123682e9cb30031eae351764f653500b7396c9/server.jar"
        ["1.13.2"]="https://launcher.mojang.com/v1/objects/3737db93722a9e39eeada7c27e7aca28b144ffa7/server.jar"
        ["1.14"]="https://launcher.mojang.com/v1/objects/f1a0073671057f01aa843443fef34330281333ce/server.jar"
        ["1.14.1"]="https://launcher.mojang.com/v1/objects/ed76d597a44c5266be2a7fcd77a8270f1f0bc118/server.jar"
        ["1.14.2"]="https://launcher.mojang.com/v1/objects/808be3869e2ca6b62378f9f4b33c946621620019/server.jar"
        ["1.14.3"]="https://launcher.mojang.com/v1/objects/d0d0fe2b1dc6ab4c65554cb734270872b72dadd6/server.jar"
        ["1.14.4"]="https://launcher.mojang.com/v1/objects/3dc3d84a581f14691199cf6831b71ed1296a9fdf/server.jar"
        ["1.15"]="https://launcher.mojang.com/v1/objects/e9f105b3c5c7e85c7b445249a93362a22f62442d/server.jar"
        ["1.15.1"]="https://launcher.mojang.com/v1/objects/4d1826eebac84847c71a77f9349cc22afd0cf0a1/server.jar"
        ["1.15.2"]="https://launcher.mojang.com/v1/objects/bb2b6b1aefcd70dfd1892149ac3a215f6c636b07/server.jar"
        ["1.16"]="https://launcher.mojang.com/v1/objects/a0d03225615ba897619220e256a266cb33a44b6b/server.jar"
        ["1.16.1"]="https://launcher.mojang.com/v1/objects/a412fd69db1f81db3f511c1463fd304675244077/server.jar")

select version in ${!versions[@]}; do
    echo "Downloading server $version"
    echo "${versions[$version]}"
    wget -O server.jar "${versions[$version]}"
    break
done

echo -n "Enter server port (default 25565): "
read port
port=${port:-"25565"}

echo -n "Enter max players (default 10): "
read players
players=${players:-"10"}

echo -n "Enter minimum ram usage (default 1): "
read minRam
minRam=${minRam:-"1"}

defaultMaxRam=`free -g | grep Mem | awk '{print $NF}'`
echo -n "Enter minimum ram usage (default $defaultMaxRam): "
read maxRam
maxRam=${maxRam:-"$defaultMaxRam"}

# TODO Advance settings and such like
echo -n "Would you like to configure more settings? [y/N] "
read response
response=${response:-"n"}

mkdir -p world/datapacks

if (echo $response | grep -qPi '^y'); then 

    echo 'Please select any datapacks you would like to add:'
    pushd world/datapacks
    select p in "Capture the Flag" "Tag" "Done"; do
        case $p in
            "Capture the Flag")
                git clone https://github.com/tux2603/mc-ctf.git
                ;;
            "Tag")
                git clone https://github.com/tux2603/mc-freezetag.git
                ;;
            "Done")
                break
                ;;
        esac
    done
    popd

    echo -n "View distance (default 8): "
    read viewDistance

    echo -n "Spawn protection radius (default 16): "
    read spawnProtection

    echo -n "Op permission level (default 2): "
    read opPermissionLevel

    echo -n "Function permission level (default 2): "
    read functionPermissionLevel

    echo -n "Nether enabled (default true): "
    read allowNether

    echo -n "Enable whitelist (default false): "
    read whitelist

    echo -n "Spawn NPCs (default true): "
    read spawnNPCS 

    echo -n "Spawn animals (default true): "
    read spawnAnimals

    echo -n "Spawn monsters (default true): "
    read spawnMonsters

    echo -n "Message of the day (default shameless plug): "
    read motd
    

fi

viewDistance=${viewDistance:-"8"}
spawnProtection=${spawnProtection:-"16"}
opPermissionLevel=${opPermissionLevel:-"2"}
functionPermissionLevel=${functionPermissionLevel:-"2"}
allowNether=${allowNether:-"true"}
whitelist=${whitelist:-"false"}
spawnNPCS=${spawnNPCS:-"true"}
spawnAnimals=${spawnAnimals:-"true"}
spawnMonsters=${spawnMonsters:-"true"}
motd=${motd:-"Fork me on github! https://github.comtux2603/"}

echo "Configuring server..."

cat << EOF >server.properties
#Minecraft server properties
broadcast-rcon-to-ops=true
view-distance=$viewDistance
max-build-height=256
server-ip=
rcon.port=25575
level-seed=
allow-nether=$allowNether
gamemode=survival
enable-command-block=true
server-port=$port
enable-rcon=false
enable-query=false
op-permission-level=$opPermissionLevel
prevent-proxy-connections=false
generator-settings=
resource-pack=
player-idle-timeout=0
level-name=world
rcon.password=
motd=$motd
query.port=25565
force-gamemode=false
hardcore=false
white-list=$whitelist
broadcast-console-to-ops=true
pvp=true
spawn-npcs=$spawnNPCS
spawn-animals=$spawnAnimals
generate-structures=true
snooper-enabled=true
difficulty=normal
function-permission-level=$functionPermissionLevel
network-compression-threshold=256
level-type=default
max-tick-time=60000
spawn-monsters=$spawnMonsters
enforce-whitelist=false
max-players=$players
use-native-transport=true
spawn-protection=$spawnProtection
resource-pack-sha1=
online-mode=true
allow-flight=true
max-world-size=29999984
EOF

cat << EOF >startServer.sh
#!/bin/bash
java -Xmx${maxRam}G -Xms${minRam}G -jar server.jar nogui
EOF

chmod 0755 startServer.sh

echo "Done. Start the server by running './startServer.sh'"
