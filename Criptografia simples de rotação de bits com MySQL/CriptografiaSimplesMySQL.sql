DROP FUNCTION IF EXISTS CriptoStr;
​
DELIMITER $
CREATE FUNCTION IF NOT EXISTS CriptoStr(str VARCHAR(255), bytes INT)
-- bytes é o parâmetro de bits a seram rotacionados para a esquerda
RETURNS VARCHAR(255)
BEGIN
    DECLARE result VARCHAR(255);
    DECLARE i, c INTEGER;
    DECLARE hexStr VARCHAR(2);
    SET i = 1;
    SET result = "";
    WHILE i <= LENGTH(str) DO
        SET c = CAST(ASCII(SUBSTRING(str, i, 1)) AS INT);
        SET c = (((c << bytes & 65280) >> 8) | ((c << bytes) & 255));       
        SET hexStr = HEX(c);        
        IF LENGTH(hexStr) < 2 THEN
            SET hexStr = CONCAT("0", hexStr);
        END IF;
        SET result = CONCAT(result, hexStr);
        SET i = i + 1;    
    END WHILE;    
    RETURN result;
END$
DELIMITER ;
​
SELECT CriptoStr("Hello world!", 5) AS Txt;
​
​
​
DROP FUNCTION IF EXISTS UncriptoStr;
​
DELIMITER $
CREATE FUNCTION IF NOT EXISTS UncriptoStr(str VARCHAR(255), bytes INT)
-- bytes é o parâmetro de bits a seram desrotacionados para a direita
RETURNS VARCHAR(255)
BEGIN
    DECLARE result VARCHAR(255);
    DECLARE hexStr VARCHAR(2);
    DECLARE i, c INTEGER;
    SET i = 1;
    SET result = "";
    WHILE i <= (LENGTH(str) / 2) DO
        SET hexStr = SUBSTRING(str, (i * 2) - 1, 2);
        SET c = CAST(CONV(hexStr, 16, 10) AS INT);    
        SET c = ((((c * 256) >> bytes) & 255) | (((c * 256) >> bytes & 65280) >> 8)) & 255;        
        SET result = CONCAT(result, CHAR(c));
        SET i = i + 1;    
    END WHILE;    
    RETURN result;
END$
DELIMITER ;
​
SELECT UncriptoStr("09AC8D8DED04EEED4E8D8C24", 5);