-- Exercício 1: a) Faça um resumo da quantidade vendida (SalesQuantity) de acordo com o canal de vendas (channelkey).
SELECT TOP(100) * FROM FactSales
SELECT * FROM DimChannel

SELECT
	--FactSales.channelKey AS 'ID Canal de Vendas',
	DimChannel.ChannelName AS 'Nome do Canal de Vendas',
	SUM(FactSales.SalesQuantity) AS 'Qtd Vendida'
FROM
	FactSales, DimChannel
WHERE
	FactSales.channelKey = DimChannel.ChannelKey
GROUP BY
	DimChannel.ChannelName

-- b) Faça um agrupamento mostrando a quantidade total vendida (SalesQuantity) e quantidade total devolvida (Return Quantity) de acordo com o ID das lojas (StoreKey).
SELECT
	StoreKey AS 'ID Loja',
	SUM(SalesQuantity) AS 'Qtd Total Vendida',
	SUM(ReturnQuantity) AS 'Qtd Total Devolvida'
FROM
	FactSales
GROUP BY 
	StoreKey
ORDER BY
	StoreKey


-- c) Faça um resumo do valor total vendido (SalesAmount) para cada canal de venda, mas apenas para o ano de 2007.
SELECT
	DimChannel.ChannelName AS 'Canal de Vendas',
	SUM(FactSales.SalesAmount) AS 'Valor Total Vendido'
FROM
	FactSales, DimChannel
WHERE
	FactSales.channelKey = DimChannel.ChannelKey
	AND FactSales.DateKey LIKE '%2007%'
GROUP BY
	DimChannel.ChannelName


-- Exercício 2: Você precisa fazer uma análise de vendas por produtos. O objetivo final é descobrir o valor total vendido (SalesAmount) por produto (ProductKey).

-- a) A tabela final deverá estar ordenada de acordo com a quantidade vendida e, além disso, mostrar apenas os produtos que tiveram um resultado final de vendas maior do que $5.000.000.
SELECT
	ProductKey AS 'ID Produto',
	SUM(SalesAmount) AS 'Valor Total Vendido'
FROM
	FactSales
GROUP BY
	ProductKey
HAVING
	SUM(SalesAmount) > 5000000
ORDER BY
	'Valor Total Vendido'

-- b) Faça uma adaptação no exercício anterior e mostre os Top 10 produtos com mais vendas. Desconsidere o filtro de $5.000.000 aplicado.
SELECT
	TOP(10) 
	ProductKey AS 'ID Produto',
	SUM(SalesAmount) AS 'Valor Total Vendido'
FROM
	FactSales
GROUP BY
	ProductKey
ORDER BY
	'Valor Total Vendido' DESC


-- Exercício 3: a) Você deve fazer uma consulta à tabela FactOnlineSales e descobrir qual é o ID (CustomerKey) do cliente que mais realizou compras online (de acordo com a coluna SalesQuantity).
SELECT TOP(100)* FROM FACTONLINESALES

SELECT
	TOP(1)
	CustomerKey AS 'ID Cliente',
	SUM(SalesQuantity) AS 'Qtd Compras Online'
FROM
	FactOnlineSales
GROUP BY
	CustomerKey
ORDER BY
	'Qtd Compras Online' DESC

-- b) Feito isso, faça um agrupamento de total vendido (SalesQuantity) por ID do produto e descubra quais foram os top 3 produtos mais comprados pelo cliente da letra a). [ID CLIENTE: 19037]
SELECT
	TOP(3)
	ProductKey AS 'ID Produto',
	SUM(SalesQuantity) AS 'Total Vendido'
FROM
	FactOnlineSales
WHERE
	CustomerKey = 19037
GROUP BY
	ProductKey
ORDER BY
	'Total Vendido' DESC


-- Exercício 4: a) Faça um agrupamento e descubra a quantidade total de produtos por marca.
SELECT * FROM DimProduct

SELECT
	BrandName AS 'Marca',
	COUNT(*) AS 'Qtd de Produtos'
FROM
	DimProduct
GROUP BY
	BrandName

-- b) Determine a média do preço unitário (UnitPrice) para cada ClassName.
SELECT
	ClassName AS 'Classe do Produto',
	AVG(UnitPrice) AS 'Média do Preço Unitário'
FROM
	DimProduct
GROUP BY
	ClassName

-- c) Faça um agrupamento de cores e descubra o peso total que cada cor de produto possui.
SELECT
	ColorName AS 'Cor',
	SUM(Weight) AS 'Peso Total (lbs)'
FROM
	DimProduct
GROUP BY
	ColorName


-- Exercício 5: Você deverá descobrir o peso total para cada tipo de produto (StockTypeName). A tabela final deve considerar apenas a marca ‘Contoso’ e ter os seus valores classificados em ordem decrescente.
SELECT
	StockTypeName AS 'Tipo de Produto',
	SUM(Weight) AS 'Peso total (lbs)'
FROM
	DimProduct
WHERE
	BrandName = 'Contoso'
GROUP BY
	StockTypeName
ORDER BY
	'Peso Total (lbs)' DESC


-- Exercício 6:Você seria capaz de confirmar se todas as marcas dos produtos possuem à disposição todas as 16 opções de cores?
SELECT
	BrandName AS 'Marca do Produto',
	COUNT(DISTINCT ColorName) AS 'Qtd de cores distintas'
FROM
	DimProduct
GROUP BY 
	BrandName
-- Para exibir somente as marcas que possuem todas as cores à disposição
HAVING
	COUNT(DISTINCT ColorName) >= 16


-- Exercício 7: Faça um agrupamento para saber o total de clientes de acordo com o Sexo e também a média salarial de acordo com o Sexo. Corrija qualquer resultado “inesperado” com os seus conhecimentos em SQL.
SELECT TOP(100)* FROM DimCustomer

-- total de clientes e média salarial de acordo com o Sexo
SELECT
	Gender AS 'Sexo',
	COUNT(Gender) AS 'Total de Clientes',
	AVG(YearlyIncome) AS 'Média Salarial Anual'
FROM
	DimCustomer
WHERE
	Gender IS NOT NULL
GROUP BY
	Gender


-- Exercício 8: Faça um agrupamento para descobrir a quantidade total de clientes e a média salarial de acordo com o seu nível escolar. Utilize a coluna Education da tabela DimCustomer para fazer esse agrupamento.
SELECT
	Education AS 'Nível Escolar',
	COUNT(*) AS 'Qtd Total de Clientes',
	AVG(YearlyIncome) AS 'Média Salarial Anual'
FROM
	DimCustomer
WHERE
	Education IS NOT NULL
GROUP BY
	Education


-- Exercício 9: Faça uma tabela resumo mostrando a quantidade total de funcionários de acordo com o Departamento (DepartmentName). Importante: Você deverá considerar apenas os funcionários ativos.
SELECT * FROM DimEmployee

SELECT
	DepartmentName AS 'Departamento',
	COUNT(*) AS 'Qtd Funcionários'
FROM
	DimEmployee
WHERE
	EndDate IS NULL
GROUP BY
	DepartmentName


-- Exercício 10: Faça uma tabela resumo mostrando o total de VacationHours para cada cargo (Title). Você deve considerar apenas as mulheres, dos departamentos de Production, Marketing, Engineering e Finance, para os funcionários contratados entre os anos de 1999 e 2000.

SELECT
	Title AS 'Cargo',
	SUM(VacationHours) AS 'Total'
FROM
	DimEmployee
WHERE
	Gender = 'F'
	AND DepartmentName IN ('Production', 'Marketing', 'Engineering', 'Finance')
	AND HireDate BETWEEN '1999-01-01' AND '2000-12-31'
GROUP BY
	Title