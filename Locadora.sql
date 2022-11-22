USE exercicio_SQL_locadora

/*
1) Consultar, num_cadastro do cliente, nome do cliente, titulo do filme, data_fabricação do dvd, valor da locação, dos dvds que tem a maior data de fabricação dentre todos os cadastrados.
*/
SELECT c.num_cadastro, c.nome, f.titulo, d.data_fabricacao, l.valor
FROM cliente c, filme f, dvd d, locacao l 
WHERE l.dvd_num = d.num
      AND f.id = d.filme_id
	  AND c.num_cadastro = l.cliente_num_cadastro
	  AND d.data_fabricacao IN
	  (
	    SELECT  MAX(d.data_fabricacao)
	    FROM dvd d 
	  )

/*
2) Consultar Consultar, num_cadastro do cliente, nome do cliente, data de locação (Formato DD/MM/AAAA) e a quantidade de DVD´s alugados por cliente (Chamar essa coluna de qtd), por data de locação
*/
SELECT DISTINCT c.num_cadastro, c.nome,
	   CONVERT(CHAR(10), l.data_locacao, 103) AS data_locacao,
	   COUNT(l.dvd_num) AS qtd
FROM cliente c, locacao l, dvd d
WHERE c.num_cadastro = l.cliente_num_cadastro
      AND l.dvd_num = d.num
GROUP BY c.num_cadastro, c.nome, l.data_locacao

/*
3) Consultar Consultar, num_cadastro do cliente, nome do cliente, data de locação (Formato DD/MM/AAAA) e a valor total de todos os dvd´s alugados (Chamar essa coluna de valor_total), por data de locação
*/
SELECT DISTINCT c.num_cadastro, c.nome,
	   CONVERT(CHAR(10), l.data_locacao, 103) AS data_locacao,
	   SUM(l.valor) AS valor_total
FROM cliente c, locacao l, dvd d
WHERE c.num_cadastro = l.cliente_num_cadastro
      AND l.dvd_num = d.num
GROUP BY c.num_cadastro, c.nome, l.data_locacao 

/*
4) Consultar Consultar, num_cadastro do cliente, nome do cliente, Endereço concatenado de logradouro e numero como Endereco, data de locação (Formato DD/MM/AAAA) dos clientes que alugaram mais de 2 filmes simultaneamente
*/
SELECT DISTINCT c.num_cadastro, c.nome,
	   c.logradouro + ', ' + CAST(c.num AS VARCHAR(5)) AS Endereço,
	   CONVERT(CHAR(10), l.data_locacao, 103) AS data_locacao 
FROM cliente c, locacao l
WHERE c.num_cadastro = l.cliente_num_cadastro
GROUP BY c.num_cadastro, c.nome, c.logradouro, c.num, l.data_locacao
HAVING COUNT(l.dvd_num) > 2 

--Consulta todas as linhas e todas as colunas cliente, estrela, dvd, filme, filme_estrela, locacao
SELECT * FROM cliente 
SELECT * FROM estrela
SELECT * FROM dvd
SELECT * FROM filme
SELECT * FROM filme_estrela
SELECT * FROM locacao