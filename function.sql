DROP TEMPORARY table if exists brackets;
DROP TEMPORARY table if exists transactions;

CREATE TEMPORARY TABLE brackets (min_limit decimal(10,2), max_limit decimal(10,2), tax_rate decimal(10,2));
INSERT INTO brackets values (0, 10, 0), (10, 20, 7.5), (20, 35, 8.5), (35, 40, 10.5);

CREATE TEMPORARY TABLE transactions (value double);
insert into transactions values (5);

select 
(tr.value - br.min_limit) * br.tax_rate / 100 + 
(select ifnull(sum((brk.max_limit - brk.min_limit) * brk.tax_rate / 100), 0)
from brackets brk where brk.max_limit <= br.min_limit) 'taxa'
from transactions tr 
inner join brackets br on tr.value > br.min_limit and tr.value <= br.max_limit;
