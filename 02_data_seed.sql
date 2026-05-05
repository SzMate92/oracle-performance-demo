--------------------------------------------------
-- 02_data_seed.sql                             --
-- ENG: Populate the table with random data.    --
-- HUN: Tábla feltöltése random adatokkal.      --
--------------------------------------------------

SET SERVEROUTPUT ON;

BEGIN
    INSERT INTO employees (first_name, 
                           last_name,
                           email,
                           salary,
                           department_id,
                           status)
    SELECT
        'First_' || level,
        'Last_' || level,
        'user' || level || '@company.hu',
        ROUND(DBMS_RANDOM.VALUE(251000 , 800000), -3),
            -- ENG: Rounding the random value to 1000, that we get real salary value.".
            -- HUN: 1000-re kerekítem a random értéket, hogy reális fizetési értékeket kapjunk.    
        TRUNC(DBMS_RANDOM.VALUE(1 , 11)),            
            -- ENG: Department_id has number generator from 1 to 10.
            -- HUN: Department_id szám generátora 1-10-ig.
        'ACTIVE'
    FROM dual
    CONNECT BY level <= 5000;
    
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('HUN: 5000 rekord sikeresen legenerálva!');
    DBMS_OUTPUT.PUT_LINE('ENG: 5000 record hase been successfully generated!');

END;

/