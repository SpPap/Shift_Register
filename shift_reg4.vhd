--Implementation of CD54HC194 (shift register 4-bit)
--Behavioral modeling

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY SHIFT_REG4 IS
    PORT (
        D : IN STD_LOGIC_VECTOR(0 TO 3); --PARALLEL LOAD
        S : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        MR : IN STD_LOGIC; --MASTER RESET (ACTIVE LOW)
        CP : IN STD_LOGIC; --CLOCK
        DSL, DSR : IN STD_LOGIC; --SHIFT LEFT/RIGHT
        Q : OUT STD_LOGIC_VECTOR(0 TO 3) --OUTPUT
    );

END ENTITY;

ARCHITECTURE B1 OF SHIFT_REG4 IS
    SIGNAL Q_TEMP : STD_LOGIC_VECTOR(0 TO 3);

BEGIN

    PROCESS (CP, MR)
    BEGIN

        IF (MR = '0') THEN
            Q_TEMP <= "0000";
        ELSE
            IF (CP'EVENT AND CP = '1') THEN
                IF (S = "11") THEN
                    Q_TEMP <= D;
                ELSIF (S = "10") THEN
                    Q_TEMP(0) <= Q_TEMP(1);
                    Q_TEMP(1) <= Q_TEMP(2);
                    Q_TEMP(2) <= Q_TEMP(3);
                    Q_TEMP(3) <= DSL;
                ELSIF (S = "01") THEN
                    Q_TEMP(0) <= DSR;
                    Q_TEMP(1) <= Q_TEMP(0);
                    Q_TEMP(2) <= Q_TEMP(1);
                    Q_TEMP(3) <= Q_TEMP(2);
                END IF;
            END IF;
        END IF;
        Q <= Q_TEMP;

    END PROCESS;

END ARCHITECTURE;