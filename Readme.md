# PL/SQL Bulk Process & Salary Engine


## What about this project? (ENG)
I created a salary raiser engine using Oracle SQL and PL/SQL. My goal was to show how to update thousands of rows fast and safe, without using too much memory or crashing on small errors.

### Technical parts:
*   **Memory:** I used `BULK COLLECT` with `LIMIT 1000` to process data in small parts.
*   **Speed:** I used `FORALL` for the fastest possible bulk updates.
*   **Errors:** I used `SAVE EXCEPTIONS`, so the engine doesn't stop if one row is bad. It saves the errors and continues with the rest.
*   **Logging:** 
    *   Triggers save every salary change automatically.
    *   I used `PRAGMA AUTONOMOUS_TRANSACTION` to save errors even if the main process fails.

### Files:
1.  **01_tables_schema.sql**: Tables for employees, logs, and errors.
2.  **02_data_seed.sql**: Generates 5,000 random records for testing.
3.  **03_triggers.sql**: Watchers for tracking changes and catching errors.
4.  **04_package.sql**: The "Engine" with the main PL/SQL logic and bulk process.
5.  **05_test_cases.sql**: Simple script to test everything and see the results.

### How to use:
Run the scripts in order from 01 to 05 (for example, in PL/SQL Developer).

---

## Miről szól ez a projekt? (HUN)
Megírtam egy fizetésemelő motort Oracle SQL és PL/SQL alapokon. A lényeg nem csak egy sima update, hanem az, hogy megmutassam, hogyan lehet több ezer adatot gyorsan és biztonságosan kezelni anélkül, hogy túlcsordítanánk a memóriát vagy megállna a futás egy apró hiba miatt.

### Mit tud a kód? (Technikai részek):
*   **Okos memóriakezelés:** Nem egyszerre töltöm be az összes adatot, hanem 1000-es csomagokban (`BULK COLLECT` + `LIMIT 1000`). Így stabil marad a rendszer.
*   **Gyorsaság:** `FORALL` parancsot használtam, hogy a motor a leggyorsabban végezzen a tömeges módosításokkal.
*   **Hibakezelés:** Használtam `SAVE EXCEPTIONS` ágat. Ez azért jó, mert ha egy-egy sornál hiba van, a motor nem áll le, hanem megy tovább a többi 999 sorral, a hibát meg elmenti későbbre.
*   **Naplózás (Logging):** 
    *   Triggerek figyelik a háttérben, ha változik a fizetés.
    *   Csináltam egy külön hibanaplózót is (`PRAGMA AUTONOMOUS_TRANSACTION`), ami akkor is elmenti a hibát, ha a fő folyamat hibára futna.

### Mi van a fájlokban?
1.  **01_tables_schema.sql**: Alapozás. Itt hozom létre a táblákat (dolgozók, statisztika, hibák).
2.  **02_data_seed.sql**: Adatgenerálás. Feltöltöm a rendszert 5000 random adattal.
3.  **03_triggers.sql**: A "figyelők". Ezek mentik a változásokat és kapják el a hibákat a tábla szintjén.
4.  **04_package.sql**: Maga a Motor. Itt van az összes PL/SQL logika és a bulk folyamat.
5.  **05_test_cases.sql**: A próba. Itt tudod letesztelni és megnézni az eredményt.

### Hogyan használd:
Futtasd a szkripteket sorrendben 01-től 05-ig. (Például PL/SQL Developer-ben).

---

