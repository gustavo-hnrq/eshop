-- 2. Inserção

-- 2 A) 

SELECT name FROM product;

-- 2 B) 

SELECT name FROM users;

-- 2 C) 

SELECT name FROM store;

-- 2 D)	

SELECT
	name as NOME,
	streetaddr AS ENDERECO
FROM address;

-- 2 E)

SELECT name, type FROM product
WHERE type = "laptop";

-- 2 F)

SELECT
	streetaddr AS ENDERECO, 
	startTime AS HORA_INICIO,
    endTime AS HORA_FINAL
FROM servicepoint
JOIN after_sales_service_at ON pk_spid = fk_spid
JOIN brand ON fk_brandName = pk_brandName
JOIN product ON pk_brandName = fk_brandName
JOIN comments ON pk_pid = fk_pid
;




