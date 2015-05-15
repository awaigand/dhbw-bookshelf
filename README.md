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

1. 25 Commits
2. Jeder Commit hat Sinnvollen Inhalt

## Gems

1. Es wird Boostrap verwendet
2. Als nicht-standart Gem wird mindestens GoogleBooks verwendet
3. Als Zusatzfeature hat das books Modell zwei Scopes, für Bücher mit Author xx und Lender xx

