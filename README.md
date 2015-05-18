# Kurzbeschreibung

Das DHBW-Bookshelf dient als simple Verwaltung einer privaten Bibliothek mit Ausleihfunktion.
Der Nutzer kann:
1. Lender anlegen, d.h. Leute die sich Bücher von ihm ausleihen
2. Kann nach ISBN für ein exaktes Buch oder nach Text für eine Textsuche suchen (z.b. nach author oder title etc.) Für die Ergebnisse wird die Google Books API verwendet.
3. Bücher die in dieser Suche gefunden werden werden im AR gespeichert. Für die Authoren des Buches wird entweder ein neuer Author Record angelegt, oder sie werden bei übereinstimmenden Namen mit dem gleichen Author Record verknüpft.
4. In der Authorenübersicht werden alle Authoren und deren entsprechende Bücher angezeigt
5. In der Lender übersicht werden alle Lender und deren ausgeliehene Bücher angezeigt.
6. In der Buchübersicht kann man angeben, dass ein Lender sich ein Buch ausgeliehen hat oder das er es wieder zurückgegeben hat. 

# Wie erfüllt dieses Repository die Anforderungen?

## Modelle (20 Punkte)

1. 3 Modelle (author, book, lender)
2. Alle Modelle sind sinnvoll Verbunden.
3. Author <-> Book ist eine Many to Many Verbindung
4. Alle Modelle haben mindestens eine Validation, Author hat sogar zwei (uniqueness and presence of name)

## Tests (50 Punkte)

1. 52 Tests
2. Davon 2 Integrations-Tests und 6 Model-Tests 
3. Ausgeführt auf Windows 7 sind alle grün, alle haben mindestens eine Assertion und schlagen Fehl wenn Produktivcode geändert wird

## Code Abdeckung (10 Punkte)

1. Coverage laut simplecov 99.58%
2. Die Tests sind allerdings nicht gleich wichtig, was auch fast unmöglich ist (manche Tests testen die ganze Methode, andere speziell die zweite Hälfte einer Oder Bedingung)

## Commits (10 Punkte)

1. 27 Commits
2. Jeder Commit hat Sinnvollen Inhalt

## Gems

1. Es wird Boostrap verwendet
2. Als nicht-standart Gem wird mindestens GoogleBooks verwendet
3. Als Zusatzfeature hat das books Modell zwei Scopes, für Bücher mit Author xx und Lender xx
4. Es werden außerdem zwei AR-Callbacks verwendet um die Many-to-Many Verknüpfung etwas aufzuräumen.

# Weiteres

1. Wegen dem GoogleBooks Gem wird eine Art Mocking verwendet, welches die Unit Tests ermöglicht. Allerdings wird hierfür keine Library verwendet.
2. Das Grundlegende Scaffolding wurde ohne VCS erstellt, weswegen der initial commit schon ziemlich groß ist.
3. Die meisten Forms werden ohne den Form Helper erstellt, da dieser Code noch aus einer Zeit vor meiner Vertrautheit mit dem Form Helper stammt.

