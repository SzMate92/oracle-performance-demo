----------------------------------------------------------------
-- 04_package.sql                                             --
-- ENG: Salary raiser logic, the motor and error handling.    --
-- HUN: Fizetésemelés logika, a motor és hibakezelés.         --
----------------------------------------------------------------

CREATE OR REPLACE PACKAGE pkg_employee_management AS
    PROCEDURE prc_salary_raiser;
END pkg_employee_management;

/

CREATE OR REPLACE PACKAGE BODY pkg_employee_management IS

    PROCEDURE prc_error_log (p_name VARCHAR2, p_msg VARCHAR2) IS
        PRAGMA AUTONOMOUS_TRANSACTION;
    BEGIN
        INSERT INTO error_log (error_type, message)
        VALUES (p_name, p_msg);
        COMMIT;
    END prc_error_log;

    FUNCTION fnc_raiser (p_salary NUMBER) RETURN NUMBER IS
        new_sal NUMBER := p_salary;
    BEGIN
        IF new_sal < 450000 THEN
            new_sal := new_sal * 1.2;
        ELSE 
            new_sal := new_sal * 1.1;
        END IF;
    
    RETURN new_sal;
          
    END fnc_raiser; 
    
    PROCEDURE prc_salary_raiser IS
        TYPE t_emp IS TABLE OF employees%ROWTYPE;
        v_emp t_emp;
    
        CURSOR c_emp IS SELECT * FROM employees;
        
    BEGIN
        OPEN c_emp;
        LOOP
            FETCH c_emp BULK COLLECT INTO v_emp LIMIT 1000;
            EXIT WHEN v_emp.COUNT = 0;
            BEGIN
                FORALL i IN 1..v_emp.COUNT SAVE EXCEPTIONS
                    UPDATE employees
                    SET salary = fnc_raiser(v_emp(i).salary)
                    WHERE employee_id = v_emp(i).employee_id;
                    
            EXCEPTION
                WHEN OTHERS THEN
                    IF SQL%BULK_EXCEPTIONS.COUNT > 0 THEN
                        prc_error_log('An error occurred!' , 'Numbers of Error: ' || SQL%BULK_EXCEPTIONS.COUNT);
                            FOR r IN 1..SQL%BULK_EXCEPTIONS.COUNT LOOP
                                prc_error_log('Exact error!' , 'Row: ' || SQL%BULK_EXCEPTIONS(r).ERROR_INDEX || ' Error: ' || SQLERRM(-SQL%BULK_EXCEPTIONS(r).ERROR_CODE));
                            END LOOP;
                    ELSE
                        prc_error_log('Other_Error' , SQLERRM);
                    END IF;
            END;
        END LOOP;    
        CLOSE c_emp;
    
    END prc_salary_raiser;

END pkg_employee_management;

/
    
