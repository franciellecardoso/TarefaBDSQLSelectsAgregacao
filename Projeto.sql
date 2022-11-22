USE exercicio_SQL_projeto

--Consultar:
/*
• Quantos projetos não tem usuários associados a ele. A coluna deve chamar qty_projects_no_users
*/
SELECT COUNT(p.id) AS qtd_projects_no_users 
FROM projects p LEFT OUTER JOIN users_has_projects uhp
ON p.id = uhp.projects_id
WHERE uhp.users_id IS NULL

/*
• Id do projeto, nome do projeto, qty_users_project (quantidade de usuários por projeto) 
em ordem alfabética crescente pelo nome do projeto
*/
SELECT p.id, p.name, 
	   COUNT(u.id) AS qtd_users_project 
FROM projects p, users u, users_has_projects uhp
WHERE p.id = uhp.projects_id
      AND u.id = uhp.users_id 
GROUP BY p.id, p.name
ORDER BY p.name ASC

--Consulta todas as linhas e todas as coluna projects, users, users_has_projects
SELECT * FROM projects
SELECT * FROM users
SELECT * FROM users_has_projects