SET @texto = "Este é o meu texto criptografado";
SET @chave = SHA2("A TK2000 é massa!", 512);
SET @textoCripto = AES_ENCRYPT(@texto, @chave);
SET @textoDescriptografado = AES_DECRYPT(@textoCripto, @chave); 
SELECT @texto AS TextoOriginal, @chave AS Chave, @textoCripto AS TextoCriptografado, @textoDescriptografado AS TextoDescriptografado;

