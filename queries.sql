set @data_inicio = '2021-01-01 00:00:00';
set @data_final = '2021-01-31 23:59:59';

DROP TEMPORARY TABLE IF EXISTS credito_mensal;
DROP TEMPORARY TABLE IF EXISTS utilizacoes_anteriores;
DROP TEMPORARY TABLE IF EXISTS utilizacoes_atuais;
DROP TEMPORARY TABLE IF EXISTS utilizacoes_totais;

CREATE TEMPORARY TABLE credito_mensal select c.apartamento_id, sum(c.valor) 'total_creditos', sum(sum(c.valor)) over (partition by c.apartamento_id order by c.created_at) 'credito_acumulado', DATE_FORMAT(c.created_at, '%m-%Y') 'mes_referencia', IFNULL(b.taxa, 0.00) 'taxa' 
from creditos c left join bandeiras b on b.id = c.bandeira_id
group by c.apartamento_id, MONTH(c.created_at), YEAR(c.created_at), b.taxa
order by c.apartamento_id, c.created_at;

CREATE TEMPORARY TABLE utilizacoes_anteriores select apartamento_id, sum(valor) 'valor_utilizacoes' from utilizacoes where created_at <= DATE_ADD(@data_inicio, INTERVAL -1 SECOND) group by apartamento_id;

CREATE TEMPORARY TABLE utilizacoes_atuais select apartamento_id, sum(valor) 'valor_utilizacoes' from utilizacoes where created_at between @data_inicio and @data_final order by apartamento_id;

CREATE TEMPORARY TABLE utilizacoes_totais select a.id 'apartamento_id', ifnull(uan.valor_utilizacoes, 0) 'utilizacao_anterior', ifnull(uat.valor_utilizacoes, 0) 'utilizacao_atual', ifnull(uan.valor_utilizacoes, 0) + ifnull(uat.valor_utilizacoes, 0) 'utilizacao_total' 
from apartamentos a 
left join utilizacoes_anteriores uan on uan.apartamento_id = a.id
left join utilizacoes_atuais uat on uat.apartamento_id = a.id
