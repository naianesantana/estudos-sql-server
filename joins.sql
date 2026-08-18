-- Exercício 1: Utilize o INNER JOIN para trazer os nomes das subcategorias dos produtos, da tabela DimProductSubcategory para a tabela DimProduct.
/*SELECT * FROM DimProduct
SELECT * FROM DimProductSubcategory*/

SELECT
	ProductKey AS 'ID Produto',
	ProductName AS 'Nome do Produto',
	ProductSubcategoryName AS 'Subcategoria do Produto'
FROM
	DimProduct
INNER JOIN DimProductSubcategory
	ON DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey

-- Exercício 2: Identifique uma coluna em comum entre as tabelas DimProductSubcategory e DimProductCategory. Utilize essa coluna para complementar informações na tabela DimProductSubcategory a partir da DimProductCategory. Utilize o LEFT JOIN.
/*SELECT * FROM DimProductSubcategory
SELECT * FROM DimProductCategory*/

SELECT
	ProductSubcategoryKey AS 'ID Subcategoria',
	ProductSubcategoryName AS 'Nome da Subcategoria',
	DimProductSubcategory.ProductCategoryKey AS 'ID Categoria',
	ProductCategoryName AS 'Nome da Categoria'
FROM
	DimProductSubcategory
LEFT JOIN DimProductCategory
	ON DimProductSubcategory.ProductCategoryKey = DimProductCategory.ProductCategoryKey

-- Exercício 3: Para cada loja da tabela DimStore, descubra qual o Continente e o Nome do País associados (de acordo com DimGeography). Seu SELECT final deve conter apenas as seguintes colunas: StoreKey, StoreName, EmployeeCount, ContinentName e RegionCountryName. Utilize o LEFT JOIN neste exercício.
SELECT * FROM DimStore
SELECT * FROM DimGeography

SELECT
	StoreKey AS 'ID Loja',
	StoreName AS 'Nome da Loja',
	EmployeeCount AS 'Qtd Funcionários',
	ContinentName AS 'Nome do Continente',
	RegionCountryName AS 'Nome do País'
FROM
	DimStore
LEFT JOIN DimGeography
	ON DimStore.GeographyKey = DimGeography.GeographyKey

-- Exercício 4: Complementa a tabela DimProduct com a informação de ProductCategoryDescription. Utilize o LEFT JOIN e retorne em seu SELECT apenas as 5 colunas que considerar mais relevantes.
/*SELECT * FROM DimProduct
SELECT * FROM DimProductSubcategory
SELECT * FROM DimProductCategory*/

SELECT
	ProductKey AS 'ID Produto',
	ProductName AS 'Nome do Produto',
	BrandName AS 'Marca',
	DimProductCategory.ProductCategoryKey AS 'ID Categoria do Produto',
	ProductCategoryDescription AS 'Descrição da Categoria do Produto'
FROM 
	DimProduct
LEFT JOIN DimProductSubcategory
	ON DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey
		LEFT JOIN DimProductCategory
			ON DimProductSubcategory.ProductCategoryKey = DimProductCategory.ProductCategoryKey

-- Exercício 5: A tabela FactStrategyPlan resume o planejamento estratégico da empresa. Cada linha representa um montante destinado a uma determinada AccountKey.

-- a) Faça um SELECT das 100 primeiras linhas de FactStrategyPlan para reconhecer a tabela.
SELECT
	TOP(100)* 
FROM
	FactStrategyPlan

SELECT * FROM DimAccount

-- b) Faça um INNER JOIN para criar uma tabela contendo o AccountName para cada AccountKey da tabela FactStrategyPlan. O seu SELECT final deve conter as colunas:
-- • StrategyPlanKey
-- • DateKey
-- • AccountName
-- • Amount

SELECT
	StrategyPlanKey AS 'ID Plano Estratégico',
	DateKey AS 'Data',
	AccountName AS 'Nome da Conta',
	Amount AS 'Quantia investida'
FROM
	FactStrategyPlan
INNER JOIN DimAccount
	ON FactStrategyPlan.AccountKey = DimAccount.AccountKey
	
-- Exercício 6: Vamos continuar analisando a tabela FactStrategyPlan. Além da coluna AccountKey que identifica o tipo de conta, há também uma outra coluna chamada ScenarioKey. Essa coluna possui a numeração que identifica o tipo de cenário: Real, Orçado e Previsão.

-- Faça um INNER JOIN para criar uma tabela contendo o ScenarioName para cada ScenarioKey da tabela FactStrategyPlan. O seu SELECT final deve conter as colunas:
/* • StrategyPlanKey
   • DateKey
   • ScenarioName
   • Amount*/

-- SELECT * FROM DimScenario

SELECT
	StrategyPlanKey AS 'ID Plano Estratégico',
	DateKey AS 'Data',
	ScenarioName AS 'Tipo de Cenário',
	Amount AS 'Quantia investida'
FROM
	FactStrategyPlan
INNER JOIN DimScenario
	ON FactStrategyPlan.ScenarioKey = DimScenario.ScenarioKey

-- Exercício 7: Algumas subcategorias não possuem nenhum exemplar de produto. Identifique que subcategorias são essas.
/*SELECT * FROM DimProductSubcategory
SELECT * FROM DimProduct*/

SELECT
	ProductSubcategoryName AS 'Nome da Subcategory'
FROM
	DimProduct
RIGHT JOIN DimProductSubcategory
	ON DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey
WHERE
	ProductKey IS NULL

-- Exercício 8: A tabela abaixo mostra a combinação entre Marca e Canal de Venda, para as marcas Contoso, Fabrikam e Litware. Crie um código SQL para chegar no mesmo resultado.
/*SELECT * FROM DimProduct
SELECT TOP(100) * FROM FactSales
SELECT * FROM DimChannel*/

SELECT
	DISTINCT BrandName AS 'Marca',
	ChannelName AS 'Canal de Venda'
FROM
	DimProduct
CROSS JOIN DimChannel
WHERE
	BrandName IN ('Contoso', 'Fabrikam', 'Litware')

-- Exercício 9: Neste exercício, você deverá relacionar as tabelas FactOnlineSales com DimPromotion. Identifique a coluna que as duas tabelas têm em comum e utilize-a para criar esse relacionamento.

SELECT TOP(100) * FROM FactOnlineSales
SELECT * FROM DimPromotion

/* Retorne uma tabela contendo as seguintes colunas:
   • OnlineSalesKey
   • DateKey
   • PromotionName
   • SalesAmount

A sua consulta deve considerar apenas as linhas de vendas referentes a produtos com
desconto (PromotionName <> ‘No Discount’). Além disso, você deverá ordenar essa tabela de
acordo com a coluna DateKey, em ordem crescente.*/

SELECT 
	TOP(100) OnlineSalesKey AS 'ID Venda Online',
	DateKey AS 'Data da Venda',
	PromotionName AS 'Nome da Promoção',
	SalesAmount AS 'Valor da Venda'
FROM
	FactOnlineSales
INNER JOIN DimPromotion
	ON FactOnlineSales.PromotionKey = DimPromotion.PromotionKey
WHERE
	PromotionName <> 'No Discount'
ORDER BY
	DateKey

-- Exercício 10: A tabela abaixo é resultado de um Join entre a tabela FactSales e as tabelas: DimChannel, DimStore e DimProduct. Recrie esta consulta e classifique em ordem decrescente de acordo com SalesAmount.

SELECT TOP(100)* FROM FactSales
SELECT * FROM DimChannel
SELECT * FROM DimStore
SELECT * FROM DimProduct

SELECT
	SalesKey AS 'ID Venda', -- FactSales
	ChannelName AS 'Canal de Venda', -- DimChannel (ChannelKey) | FactSales (channelKey)
	StoreName AS 'Loja', -- DimStore (StoreKey) | FactSales (StoreKey)
	ProductName AS 'Produto', -- DimProduct (ProductKey) | FactSales (ProductKey)
	SalesAmount AS 'Valor da Venda' -- FactSales
FROM
	FactSales
INNER JOIN DimChannel
	ON FactSales.channelKey = DimChannel.ChannelKey 
INNER JOIN DimStore
	ON FactSales.StoreKey = DimStore.StoreKey
INNER JOIN DimProduct
	ON FactSales.ProductKey = DimProduct.ProductKey
ORDER BY 
	SalesAmount DESC
			