#!/bin/sh
# entrypoint.sh

echo "Aguardando 30 segundos..."
sleep 30

echo "Iniciando a aplicação..."
exec java org.springframework.boot.loader.launch.JarLauncher
