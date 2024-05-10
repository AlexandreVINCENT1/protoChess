Application native IOS. Développée avec Swift et UIKit. Testé avec IOS 17.4 sur un Iphone 15 pro émulé

Cette application communique avec l'API de chess.com afin de récupérer des informatiques basiques (player ID, date de création du compte sur chess.com, avatar, etc...)
et permet de consulter les parties jouées sur le mois en cours.

L'historique des parties se compose d'une vue avec une collection. Chaque ligne de la collection est du type : mode de jeu | pseudo de l'adversaire (point de classement) | résultat contre l'adversaire - Date du match

Résultat d'un match:

W -> Win -> ligne verte

D -> Defeat -> ligne rouge

N -> Null -> ligne grise
