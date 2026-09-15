## 1. Installation \& Start

```python
# Terminal/Konsole:
pip install streamlit

# Demo starten:
streamlit hello
```


***

## 2. Erstes Beispiel (Hello World)

```python
import streamlit as st

st.title("Meine erste Streamlit-App")
st.header("Willkommen 🚀")
st.text("Dies ist ein direkt lauffähiges Streamlit-Programm.")
```


***

## 3. Textausgabe \& Formatierung

```python
import streamlit as st

st.markdown("**Fett**, *kursiv*, [Streamlit](https://streamlit.io)")
st.code("print('Hallo Welt!')")
st.latex(r"x^2 + y^2 = z^2")
```


***

## 4. Interaktive Inputs

```python
import streamlit as st

name = st.text_input("Name eingeben")
age = st.number_input("Alter", min_value=0)
bio = st.text_area("Kurzbeschreibung")
lieblingsfarbe = st.color_picker("Lieblingsfarbe wählen")

if st.button("Bestätigen"):
    st.write(f"Name: {name}, Alter: {age}, Farbe: {lieblingsfarbe}")
```


***

## 5. User-Steuerung \& Auswahl

```python
import streamlit as st

sprache = st.radio("Lieblingssprache?", ["Python", "C++", "Java"])
zustimmen = st.checkbox("AGB akzeptieren?")
option = st.selectbox("Wähle eine Option", ["A", "B", "C"])
aktion = st.button("Abschicken")
if aktion:
    st.success(f"Auswahl: {sprache} | Option: {option} | Zustimmung: {zustimmen}")
```


***

## 6. Datenanzeige \& Visualisierung

```python
import streamlit as st
import pandas as pd
import numpy as np

df = pd.DataFrame({"Werte": np.random.randint(0, 100, 10)})
st.dataframe(df)
st.line_chart(df)
```


***

## 7. Layout: Spalten, Container, Expander, Sidebar

```python
import streamlit as st

col1, col2 = st.columns(2)
col1.write("Spalte 1")
col2.write("Spalte 2")

with st.expander("Mehr anzeigen"):
    st.write("Hier stehen weitere Details.")

st.sidebar.write("Navigation in der Seitenleiste")
```


***

## 8. Dateioperationen: Upload und Download

```python
import streamlit as st
import io

file = st.file_uploader("Datei auswählen")
if file is not None:
    st.write(f"Dateiname: {file.name}")

byte_stream = io.BytesIO(b"Demo-Text")
st.download_button("Textdatei herunterladen", byte_stream, file_name="demo.txt")
```


***

## 9. Session State

```python
import streamlit as st

if "count" not in st.session_state:
    st.session_state.count = 0

if st.button("Zähler erhöhen"):
    st.session_state.count += 1

st.write(f"Zählerstand: {st.session_state.count}")
```


***

## 10. Deployment-Hinweis

- Streamlit-Apps sind für den Web-Einsatz gedacht (Befehl: `streamlit run ...`)
- Deployment als Standalone-App: Speziallösungen mit PyInstaller sind möglich, aber nicht Standard