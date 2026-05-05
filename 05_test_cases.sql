----------------------------------------------------
-- 05_test_cases.sql                              --
-- ENG: Engine test and check the logs.           --
-- HUN: Motor tesztelése és a logok ellenőrzése.  --
----------------------------------------------------

SET SERVEROUTPUT ON;

BEGIN
DBMS_OUTPUT.PUT_LINE('ENG: Salary check, before salary raise.');
DBMS_OUTPUT.PUT_LINE('HUN: Fizetés ellenőrzés mielőtt az emelés megtörténne.');
END;

/

SELECT AVG(salary) AS avg_before FROM employees;


BEGIN
DBMS_OUTPUT.PUT_LINE('ENG: Package starting.');
DBMS_OUTPUT.PUT_LINE('HUN: Package indul. ');
END;

/

BEGIN
    pkg_employee_management.prc_salary_raiser;
END;

/

BEGIN
DBMS_OUTPUT.PUT_LINE('ENG: Package finished.');
DBMS_OUTPUT.PUT_LINE('HUN: Package befejeződött.');
END;

/

BEGIN
DBMS_OUTPUT.PUT_LINE('ENG: Check the salary raise from the trg_salary_history.');
DBMS_OUTPUT.PUT_LINE('HUN: Ellenőrizzük az emelést a trg_salary_history-ból.');
END;

/

SELECT COUNT(*) AS total_history_logs FROM salary_log;

BEGIN
DBMS_OUTPUT.PUT_LINE('ENG: Check the errors from the error_log.');
DBMS_OUTPUT.PUT_LINE('HUN: Ellenőrizzük a hibákat az error_log-ból. ');
END;

/

SELECT COUNT(*) AS total_errors FROM error_log;

BEGIN
DBMS_OUTPUT.PUT_LINE('ENG: Check the first 5 employees salary after raise.');
DBMS_OUTPUT.PUT_LINE('HUN: Ellenőrizzük a következő 5 dolgozó fizetését emelés után.');
END;

/

SELECT employee_id, first_name, salary FROM employees WHERE employee_id <= 5;

/