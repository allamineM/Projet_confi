#!/bin/bash

# Vérification de l'argument (la ville)
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <ville>"
    exit 1
fi

VILLE="$1"
FICHIER="meteo.txt"
METEO_BRUTE="meteo_brute.txt"

# 1. Récupérer les données météorologiques
echo "Récupération des données pour la ville : $VILLE"
curl -s "wttr.in/$VILLE?format=3" > "$METEO_BRUTE"
echo "Données récupérées :"
cat "$METEO_BRUTE"

# 2. Extraire la température actuelle et la prévision pour le lendemain
TEMP_ACTUELLE=$(grep -o '[0-9]*°C' "$METEO_BRUTE" | head -n 1)
TEMP_PREVISION=$(grep -o '[0-9]*°C' "$METEO_BRUTE" | tail -n 1)

# 3. Formater la date et l'heure actuelles
DATE=$(date +"%Y-%m-%d")
HEURE=$(date +"%H:%M")

# Vérifier les températures extraites
if [ -z "$TEMP_ACTUELLE" ] || [ -z "$TEMP_PREVISION" ]; then
    echo "Erreur : Impossible d'extraire les températures."
    exit 1
fi

# 4. Enregistrer les informations dans le fichier meteo.txt
echo "$DATE - $HEURE - $VILLE : $TEMP_ACTUELLE - $TEMP_PREVISION" >> "$FICHIER"
echo "Informations enregistrées dans $FICHIER"

