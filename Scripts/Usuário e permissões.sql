
--Cria o usuário que acessará o banco pelo sistema,
CREATE USER u_agendese PASSWORD '@g&nd&$&';
--Cria o grupo em que será inserido o usuário,
CREATE GROUP g_sistemas;
--Insere usuário do sistema ao grupo,
ALTER GROUP g_sistemas ADD USER u_agendese;
--Dá privilégios ao usuário no schema,
GRANT ALL ON SCHEMA rpfiorin TO g_sistemas;
--Dá privilégios a ele na tabela,
GRANT ALL ON rpfiorin.evento TO g_sistemas;
GRANT SELECT ON rpfiorin.sistema TO g_sistemas;

--Libera acesso à sequência.
--GRANT ALL ON rpfiorin.evento_id_seq TO g_sistemas;

--Tira os privilégios.
--REVOKE ALL PRIVILEGES ON rpfiorin.evento FROM u_agendese;