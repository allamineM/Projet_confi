
#!/bin/bash

# Vérifier si une ville a été fournie en argument
if [ -z "$1" ]; then
    echo "Usage : ./Extracteur_Météo.sh <ville>"
    exit 1
fi

VILLE=$1

# Utiliser curl pour récupérer les informations météorologiques brutes de wttr.in
METEO=$(curl -s "wttr.in/$VILLE?format=3")

# Vérifier si la requête a réussi
if [ -z "$METEO" ]; then
    echo "Erreur : Impossible de récupérer les informations météorologiques pour $VILLE."
    exit 1
fi

# Afficher la météo dans le terminal
echo "Météo actuelle pour $VILLE : $METEO"

# Sauvegarder les informations dans un fichier meteo.txt
echo "$(date '+%Y-%m-%d %H:%M') - $VILLE : $METEO" >> meteo.txt

