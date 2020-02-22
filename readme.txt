CHAPTER 6 Creating production grade workflow

Het opzet van dit hoofdstuk is een complete production workflow te voorzien
voor, in dit geval, een react app.

In eerste instantie wordt een Dockerfile.dev gemaakt. Deze wordt enkel in
development gebruikt. De 'docker build .' command zal weliswaar de Dockerfile zonder
extensie zoeken. Onderstaand commando voorziet de mogelijkheid een specifiek bestand
te gebruiken voor de build.
    docker build -f Dockerfile.dev .

Zoals voorheen zullen wijzigingen in de broncode niet worden gereflecteerd in de 
image die wordt aangemaakt. Reden daarvan is dat, zoals de Dockerfile beschrijft, 
de bestanden worden gekopieerd naar de image. Wijzigingen op de lokale machine
zullen dus niet worden waargenomen. Oplossing hiervoor is het gebruik van Volumes.
Een volume zal binnen de image een 'referentie' voorzien naar de broncode op de 
lokale machine.

Het commando dat hiervoor wordt gebruikt in de docker-cli is
    docker build -p 3000:3000 -v /app/node_modules -v $(pwd):/app <image_id>

Het is belangrijk te weten dat in de Dockerfile in eerste instantie de node_modules
map wordt gegenereerd dmv het npm install commando alsook alle bestanden worden
gekopieerd naar de image. 

    -v $(pwd):/app
    !! in git bash => probleem met $(pwd) => powershell gebruiken ${pwd}

Wanneer bovenstaand deel van het commando wordt uitgevoerd zullen alle bestanden in de 
frontend map als referentie worden gebruikt door de container. Belangrijk om weten
is dat de node_modules map hier niet bestaat! Deze werd wel gecreeërd in de image 
maar wanneer een volume wordt gebruikt wordt dit overschreven en een referentie voorzien 
naar, in principe, een onbestaande map. Oplossing hiervor is een bookmark te plaatsen 
op de node_modules map in de container. Deze wordt dus niet vervangen door een referentie.

    -v /app/node_modules

Door gebruik te maken van docker-compose kunnen bovenstaande stappen in een configuratie 
worden gegoten. (zie docker-compose.yml)

Bovenstaande werkwijze geeft enkel de werkwijze voor development.
Wanneer naar productie wordt gegaan moet gebruik worden gemaakt van nginx om 
de statische bestanden, die voortkomen uit npm run build, beschikbaar te maken.
    
    => zie Dockerfile


CHAPTER 7 Travis CI en AWS

In hoofdstuk 7 wordt de workflow verder uitgebreid. Hier wordt gebruik gemaakt van 
Travis CI om veranderingen die naar github worden gepushed op te vangen, de gewijzigde 
code op te vragen en vervolgens te testen en te deployen naar AWS (de hosting).

Om Travis duidelijk te maken wat er moet worden gedaan met de code, worden instructies
voorzien in een .travis.yml bestand. Verdere uitleg kan hier worden gevonden.

De toegevoegde foto 'workflow.jpg' toont de volledige workflow