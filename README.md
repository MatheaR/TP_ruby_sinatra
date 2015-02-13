# TP_ruby_sinatra
TP ruby avec Sinatra pour créer un chat avec des users, des messages, le push est en option

Demarrer MongoDB
==============
Dans une fenetre lancer : mongod
Ceci lance le serveur de la base de donnée
Dans un autre onglet il est posssible de voir le nombre de bdd en lancant :
mongo (lance le shell mongoDB)
show dbs

Demarrer le serveur
==============
Lancer ruby main.rb depuis le dossier git
Visible à l'adresse : http://localhost:4567/

A ce stade nos deux serveur tourne en local, il est possible d'acceder à notre base de donnée en tapant depuis la racine du dossier :
irb (lanche le shell ruby)
require '.main'

la dernière commande execute lappel au fichier main.rb qui lui à besoin de mongoid.yml. Ce dernier contient la configuration de notre bdd. Une fois dans le shell irb, il est possible de consulter les données de notre bdd comme afficher nos messages :
Message.all.to_a

Affiche tous les messages dans un tableau

Message.any_in(:_id => ["id_du_message"]).destroy_all

Supprime un message par son id
