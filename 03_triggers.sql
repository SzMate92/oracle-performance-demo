-----------------------------------------------------------------------------------------------
-- 03_triggers.sql                                                                           --
-- ENG: The trg_salary_history saves salary changes, so we can check them later.             --
--      The trg_error_log saves errors to the error_log table.                               --
-- HUN: A trg_salary_history menti a fizetés változásokat, hogy később vissza tudjuk nézni.  --
--      A trg_error_log elmenti a hibákat az error_log táblába.                              --
-----------------------------------------------------------------------------------------------

CREATE OR REPLACE TRIGGER trg_salary_history
BEFORE UPDATE OF salary ON employees
FOR EACH ROW

BEGIN
    INSERT INTO salary_log(employee_id, 
                           old_salary,
                           new_salary,
                           modified_by                         
                           )
    VALUES(:OLD.employee_id,
           :OLD.salary,
           :NEW.salary,
           USER
    );
END;

/

CREATE OR REPLACE TRIGGER trg_error_log
BEFORE UPDATE ON employees
FOR EACH ROW

BEGIN
    IF :NEW.salary <= :OLD.salary THEN
        INSERT INTO error_log (
            error_type,
            message,
            emp_id
        )
        VALUES (
            'NO_INCREASE',
            'New salary must be higher than the old one!',
            :OLD.employee_id
        );
    END IF;
END;

/

BEGIN
    DBMS_OUTPUT.PUT_LINE('HUN: Triggerek sikeresen letrehozva!');
    DBMS_OUTPUT.PUT_LINE('ENG: Triggers have been successfully created!');
END;                   

/