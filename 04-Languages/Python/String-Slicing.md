Um die Python-Dokumentation für String-Slicing zu finden, kann ich Ihnen helfen. In der offiziellen Python-Dokumentation wird das Slicing von Strings im Abschnitt über Sequenz-Typen (Sequence Types) erklärt, speziell in der Dokumentation zu Listen, Tupeln und Strings.

Hier ist eine kurze Erklärung der Slicing-Syntax:

```python
# Allgemeine Syntax: 
string[start:stop:step]

# Beispiele:
text = "Python"
print(text[0:3])    # Gibt "Pyt" aus (von Index 0 bis 2)
print(text[:3])     # Gibt "Pyt" aus (Start ab 0 impliziert)
print(text[2:])     # Gibt "thon" aus (bis zum Ende)
print(text[::2])    # Gibt "Pto" aus (jedes zweite Zeichen)
print(text[::-1])   # Gibt "nohtyP" aus (String umkehren)
```

Die offizielle Dokumentation finden Sie unter:

- https://docs.python.org/3/library/stdtypes.html#sequence-types-list-tuple-range

Dort wird detailliert erklärt, wie Slicing in Python funktioniert, einschließlich der Syntax und Besonderheiten bei Listen, Tupeln und Strings. Die Dokumentation bietet eine umfassende Erklärung der Slicing-Mechanismen in Python.