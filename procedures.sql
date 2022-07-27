USE EMPRESA
SELECT *FROM TELEFONE
/*DROP TABLE TELEFONE */

 CREATE TABLE PESSOA(
  IDPESSOA  INT PRIMARY KEY IDENTITY,
  NOME VARCHAR(30) NOT NULL,
  SEXO CHAR(1) NOT NULL CHECK(SEXO IN('M', 'F')),
  NASCIMENTO DATE NOT NULL
)
GO 

CREATE TABLE TELEFONE(
 IDTELEFONE INT NOT NULL IDENTITY,
 TIPO CHAR(3) NOT NULL CHECK (TIPO IN ('CEL', 'COM')),
 NUMERO CHAR(10) NOT NULL,
 ID_PESSOA INT 

)
GO

ALTER TABLE TELEFONE  ADD CONSTRAINT FK_TELEFONE_PESSOA 
FOREIGN KEY (ID_PESSOA) REFERENCES PESSOA(IDPESSOA)
ON DELETE CASCADE 
GO

INSERT INTO PESSOA VALUES('ANTONIO', 'M', '1981-02-13') 
INSERT INTO PESSOA VALUES('DANIEL ', 'M', '1985-03-18') 
INSERT INTO PESSOA VALUES('CLEIDE', 'F', '1979-10-13') 

INSERT INTO TELEFONE VALUES('CEL', '9879008', 1) 
INSERT INTO TELEFONE VALUES('COM ', '8757909', 1) 
INSERT INTO TELEFONE VALUES('CEL', '9875890', 2) 
INSERT INTO TELEFONE VALUES('CEL', '9347689', 2) 
INSERT INTO TELEFONE VALUES('COM ', '2998689', 3) 
INSERT INTO TELEFONE VALUES('COM', '2098978', 2)
INSERT INTO TELEFONE VALUES('CEL', '9008679', 3)

SELECT *FROM TELEFONE



/* CRIANDO A PROCEDURE  */
CREATE PROC SOMA 
AS SELECT  10+10 AS SOMA 
GO

/*EXECUTANDO A PROCEDURE */
SOMA

/* OU */
 EXEC SOMA
 GO

 /*DIN�MICAS COM PAR�METROS */
 CREATE PROC CONTA @NUM1 INT, @NUM2 INT
 AS 
   SELECT @NUM1 + @NUM2 AS RESULTADO 

GO
/* EXECUTANDO COM PAR�METROS*/
EXEC CONTA 90, 10


/* APAGANDO A PROCEDURE */
DROP PROC CONTA


/* PROCEDURES EM TABELAS*/

SELECT NOME, NUMERO
FROM PESSOA
INNER JOIN TELEFONE 
ON IDPESSOA = ID_PESSOA
WHERE TIPO = 'CEL'
GO

/* TRAZENDO  OS TELEFONES  DE ACORDO COM O TIPO PASSADO*/
CREATE PROC  TELEFONES @TIPO CHAR(3)
AS
  SELECT NOME, NUMERO
FROM PESSOA
INNER JOIN TELEFONE 
ON IDPESSOA = ID_PESSOA
WHERE TIPO = @TIPO

GO

EXEC  TELEFONES 'COM'

EXEC TELEFONES 'CEL'

/* PARAMETROS DE OUTPUT*/


SELECT TIPO, COUNT(*) AS QUANTIDADE 
FROM TELEFONE
GROUP BY TIPO
GO

CREATE PROCEDURE GETTIPO @TIPO CHAR(3), @CONTADOR INT OUTPUT 
AS 
   SELECT  @CONTADOR = COUNT(*)
   FROM TELEFONE
   WHERE TIPO = @TIPO
   GO


   /* EXECU��O DA PROC COM PARAMETRO DE SA�DA*/

   /*TRANSACTION  SQL ->  LINGUAGEM QUE O SQL TRABALHA*/

   DECLARE @SAIDA INT
   EXEC GETTIPO @TIPO ='CEL', @CONTADOR  = @SAIDA  OUTPUT
   SELECT @SAIDA
   GO


   SELECT @@IDENTITY -- GUARDA O �LTIMO IDENTITY INSERIDO NA SE��O
   GO


   /* PROCEDURE DE CADASTRO */
    CREATE PROC  CADASTRO @NOME VARCHAR(30), @SEXO CHAR(1), @NASCIMENTO DATE, 
	@TIPO CHAR(3), @NUMERO VARCHAR(10)
	AS
	   DECLARE @FK INT
	   
	   INSERT INTO PESSOA VALUES  (@NOME, @SEXO, @NASCIMENTO) -- GEARA UM ID

	   SET @FK = (SELECT  IDPESSOA FROM PESSOA WHERE IDPESSOA
	   = @@IDENTITY)

	   INSERT INTO TELEFONE VALUES(@TIPO, @NUMERO, @FK)

	   GO


	   CADASTRO 'JORGE', 'M', '1981-01-01', 'CEL', '965283398'
	   GO

	   /*TRUQUE*/

	   SELECT PESSOA.*, TELEFONE.*
	   FROM PESSOA
	   INNER JOIN TELEFONE 
	   ON IDPESSOA = ID_PESSOA
	   GO


	   use EMPRESA


	   /*BLOCO DE EXECU��O*/
	   BEGIN
	     PRINT 'ALTER CIENTISTA DE DADOS'
	   END
	   GO

	   /* BLOCOS DE ATRIBUI��O DE VARI�VEIS*/
   DECLARE 
      @CONTADOR INT
   BEGIN 
       SET @CONTADOR = 5
	   PRINT @CONTADOR
   END

   GO
   

   /* NO SQL SERVER CADA UMA,  VARIAVEL LOCAL, EXPRESS�O E PARAMETRO  TEM UM TIPO. */

DECLARE
 
      @V_NUMERO NUMERIC(10,2) = 100.52,
	  @V_DATA DATETIME = '20170207'
BEGIN 
      PRINT 'VALOR N�MERO: ' + CAST(@V_NUMERO AS VARCHAR)
	  PRINT 'VALOR N�MERO: ' + CONVERT(VARCHAR, @V_NUMERO)
	  PRINT 'VALOR DATA: ' + CONVERT(VARCHAR, @V_DATA, 121)
	  PRINT 'VALOR DATA: ' + CONVERT(VARCHAR, @V_DATA, 120)
	  PRINT 'VALOR DATA: ' + CONVERT(VARCHAR, @V_DATA, 105) /* BR*/
END
GO


CREATE TABLE CARROS (
    CARRO VARCHAR(20),
	FABRICANTE VARCHAR(30)
)
GO

INSERT INTO CARROS VALUES ('KA','FORD')
INSERT INTO CARROS VALUES ('FIESTA','FORD')
INSERT INTO CARROS VALUES ('PRISMA','FORD')
INSERT INTO CARROS VALUES ('CLIO','RENAULT')
INSERT INTO CARROS VALUES ('SANDERO','RENAULT')
INSERT INTO CARROS VALUES ('CHEVETE','CHEVROLET')
INSERT INTO CARROS VALUES ('OMEGA','CHEVROLET')
INSERT INTO CARROS VALUES ('PALIO','FIAT')
INSERT INTO CARROS VALUES ('DOBLO','FIAT')
INSERT INTO CARROS VALUES ('UNO','FIAT')
INSERT INTO CARROS VALUES ('GOL','VOLKSWAGEN')
GO

DECLARE
     @V_CONT_FORD INT,
	 @V_CONT_FIAT INT

  BEGIN
  -- METODO 1 - O SELECT PRECISA RETORNAR  UMA SIMPLES COLUNA 
  -- E UM S� RESULTADO 

   SET @V_CONT_FORD = (SELECT COUNT(*) FROM CARROS
   WHERE FABRICANTE = 'FORD')

   PRINT 'QUANTIDADE DE CARROS DA FORD: ' + CAST(@V_CONT_FORD AS VARCHAR)

   -- METODO 2
    SELECT @V_CONT_FIAT = COUNT(*) FROM CARROS WHERE FABRICANTE ='FIAT'

	PRINT 'QUANTIDADE DE CARROS DA FIAT: ' + CAST(@V_CONT_FIAT AS VARCHAR)

  END
  GO


  /* BLOCOS IF E ELSE */

  DECLARE

        @NUMERO INT = 5

BEGIN 
      IF @NUMERO = 5 -- EXPRESSAO  BOOLEANA - TRUEE
	  PRINT 'O VALOR � VERDADEIRO'
	  ELSE
	  PRINT 'O VALOR � FALSO'	

END
GO

CREATE PROC TESTE_EXEMPLO @NUMERO INT
AS 
    IF @NUMERO = 5 -- EXPRESSAO  BOOLEANA - TRUEE
	  PRINT 'O VALOR � VERDADEIRO'
	  ELSE
	  PRINT 'O VALOR � FALSO'	
END 


/*EXEMPLO DEU CERTO*/
 EXEC TESTE_EXEMPLO 5


/* CASE */

DECLARE 

  @CONTADOR INT

BEGIN 
      SELECT  -- O CASE REPRESENTA UMA COLUNA 
	  CASE 
	     WHEN FABRICANTE = 'FIAT' THEN 'FAIXA 1'
		 WHEN FABRICANTE = 'CHEVROLET' THEN 'FAIXA 2'
		 ELSE 'OUTRAS FAIXAS'
	END AS  "INFORMA��ES",
	* 
	FROM CARROS

END
GO


/* LOOPS WHILE */
DECLARE 

  @I INT = 1 

BEGIN 
      WHILE ( @I < 15)
	  BEGIN 
	       PRINT'VALOR DE I = ' + CAST(@I AS VARCHAR)
		   SET @I = @I + 1
	  END
END 
GO
	  




