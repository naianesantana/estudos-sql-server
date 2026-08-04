-- Exercício 1: O gerente comercial pediu a você uma análise da Quantidade Vendida e Quantidade Devolvida para o canal de venda mais importante da empresa: Store. Utilize uma função SQL para fazer essas consultas no seu banco de dados. Obs: Faça essa análise considerando a tabela FactSales.

/*SELECT
	TOP(10)*
FROM
	FactSales
	
SELECT
	TOP(10)*
FROM
	DimChannel*/

SELECT
	SUM(SalesQuantity) AS 'Quantidade Vendida',
	SUM(ReturnQuantity) AS 'Quantidade Devolvida'
FROM
	FactSales,DimChannel
WHERE
	FactSales.channelKey = DimChannel.ChannelKey
	AND DimChannel.ChannelName = 'Store'

-- [CERTO] -- Exercício 2: Uma nova ação no setor de Marketing precisará avaliar a média salarial de todos os clientes da empresa, mas apenas de ocupação Professional. Utilize um comando SQL para atingir esse resultado.

/*SELECT
	TOP(10)*
FROM
	DimCustomer*/

SELECT
	AVG(YearlyIncome) AS 'Média Salarial Anual'
FROM
	DimCustomer
WHERE
	Occupation = 'Professional'

-- [CERTO] -- Exercício 3: Você precisará fazer uma análise da quantidade de funcionários das lojas registradas na empresa. O seu gerente te pediu os seguintes números e informações:

-- a) Quantos funcionários tem a loja com mais funcionários?
-- b) Qual é o nome dessa loja?
/*SELECT
	TOP(10)*
FROM
	DimStore*/

SELECT
	TOP(1) StoreName AS 'Nome da Loja',
	EmployeeCount AS 'Qtd. de Funcionários'
FROM
	DimStore
ORDER BY
	EmployeeCount DESC

/* SELECT
	MAX(EmployeeCount) AS 'Maior Qtd. Funcionários'
FROM
	DimStore

SELECT
	StoreName AS 'Nome da Loja',
	EmployeeCount AS 'Qtd. Funcionários'
FROM
	DimStore
WHERE
	EmployeeCount = 325*/


-- c) Quantos funcionários tem a loja com menos funcionários?
-- d) Qual é o nome dessa loja?
SELECT
	TOP(1) StoreName AS 'Nome da Loja',
	EmployeeCount AS 'Qtd. de Funcionários'
FROM
	DimStore
WHERE
	EmployeeCount IS NOT NULL
ORDER BY
	EmployeeCount

-- [CERTO] -- Exercício 4: A área de RH está com uma nova ação para a empresa, e para isso precisa saber a quantidade total de funcionários do sexo Masculino e do sexo Feminino.
/*SELECT
	TOP(10)*
FROM
	DimEmployee*/

-- a) Descubra essas duas informações utilizando o SQL.
SELECT
	COUNT(*) AS 'Qtd. Funcionários Masculinos'
FROM
	DimEmployee
WHERE
	Gender = 'M'

SELECT
	COUNT(*) AS 'Qtd. Funcionários Femininos'
FROM
	DimEmployee
WHERE
	Gender = 'F'

-- b) O funcionário e a funcionária mais antigos receberão uma homenagem. Descubra as seguintes informações de cada um deles: Nome, E-mail, Data de Contratação.

-- Funcionário mais antigo do sexo Masculino
SELECT 
	TOP(1)
	FirstName AS 'Nome do Funcionário',
	EmailAddress AS 'E-mail',
	HireDate AS 'Data de Contratação'
FROM
	DimEmployee
WHERE
	Gender = 'M'
ORDER BY
	HireDate

-- Funcionário mais antigo do sexo Feminimo
SELECT
	TOP(1)
	FirstName AS 'Nome da Funcionária',
	EmailAddress AS 'E-mail',
	HireDate AS 'Data de Contratação'
FROM
	DimEmployee
WHERE
	Gender = 'F'
ORDER BY
	HireDate

-- Exercício 5: Agora você precisa fazer uma análise dos produtos. Será necessário descobrir as seguintes informações:
/*SELECT
	*
FROM
	DimProduct*/

-- a) Quantidade distinta de cores de produtos.
-- b) Quantidade distinta de marcas
-- c) Quantidade distinta de classes de produto. Para simplificar, você pode fazer isso em uma mesma consulta
SELECT
	COUNT(DISTINCT ColorName) AS 'Qtd. de Cores Existentes',
	COUNT(DISTINCT BrandName) AS 'Qtd. de Marcas Existentes',
	COUNT(DISTINCT CLassName) AS 'Qtd. de Classes Existentes'
FROM
	DimProduct
