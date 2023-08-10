// Erstellung von Nodes
CREATE (fiebig:Dozent {name: 'Fiebig', vorname: 'D.', titel: 'Prof. Dr.' })
CREATE (schmittwilken:Dozent {name: 'Schmittwilken', vorname: 'Jörg', titel: 'Dr.' })
CREATE (austrup:Dozent {name: 'Austrup', vorname: 'Sascha', titel: 'Prof. Dr.' })
// Erstellung von Edges (wenn Variable bereits vorhanden)
CREATE (fiebig)-[:IST_KOLLEGE_VON {studiengang: 'vit'}]->(schmittwilken)
CREATE (schmittwilken)-[:IST_KOLLEGE_VON {studiengang: 'vit'}]->(fiebig)
// Erstellung von Edges (Nodes suchen und verbinden)
MATCH (fiebig:Dozent), (schmittwilken:Dozent)
WHERE fiebig.name = 'Fiebig' AND schmittwilken.name = 'Schmittwilken'
CREATE (fiebig)-[:IST_KOLLEGE_VON]->(schmittwilken)
CREATE (schmittwilken)-[:IST_KOLLEGE_VON]->(fiebig)
// Alle Dozenten ausgeben
MATCH (d:Dozent)
RETURN d
// Nur einen bestimmten Dozenten ausgeben
MATCH (d:Dozent)
WHERE d.name = 'Fiebig'
RETURN d
// Ändern von Attributen einer Node (Mit SET Operator)
MATCH (d:Dozent)
WHERE d.name = 'Fiebig'
SET d.vorname = 'Daniele'
RETURN d
// Löschen von einem bestimmten Node (nur wenn diese Node keine Beziehung hat)
MATCH (d:Dozent)
WHERE d.name = 'Schmittwilken'
DELETE
// Löschen von einem bestimmten Node (und all derer Beziehungen)
MATCH (d:Dozent)
WHERE d.name = 'Schmittwilken'
DETACH DELETE
// Gebe alle Kollegen von einem Dozenten aus
MATCH (austrup:Dozent)-[:IST_KOLLEGE_VON]->(kollege:Dozent)
WHERE austrup.name = 'Austrup'
RETURN kollege
// Gebe aus wie viele Kollegen Herr Austrup hat
MATCH (austrup:Dozent)-[kollegen:IST_KOLLEGE_VON]->(:Dozent)
WHERE austrup.name = 'Austrup'
RETURN austrup.name, count(kollegen)
// Ein Dozent unterrichtet ein Modul in einem Raum
CREATE (d1:Dozent {name: 'Diedrichs'})-[:UNTERRICHTET]->(:Modul {name: 'm3'})<-[:FINDET_STATT]-(:Raum {nr: 6})
