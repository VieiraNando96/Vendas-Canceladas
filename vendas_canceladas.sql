WITH operador_venda AS (
    SELECT
        v.id,
        o.nome
    FROM pdv.venda v
    INNER JOIN pdv.operador o ON v.matricula = o.matricula
    INNER JOIN pdv.vendaitem vi ON vi.id_venda = v.id
    WHERE vi.cancelado = TRUE
      AND v.data BETWEEN '2023-09-01' AND '2023-09-30'
     
)
SELECT
    v.data,
    l.descricao AS "Loja",
    v.numerocupom AS "Numero Cupom",
    v.ecf AS "ECF",
    v.matricula AS "Matricula Operador PDV",
    COALESCE(vi.matriculacancelamento, v.matriculacancelamento) AS "Matricula Cancelamento",
    tc.descricao AS "Motivo Cancelamento"
FROM pdv.venda v
INNER JOIN pdv.vendaitem vi ON vi.id_venda = v.id
INNER JOIN pdv.operador o ON o.matricula = COALESCE(vi.matriculacancelamento, v.matriculacancelamento) AND o.id_loja = v.id_loja
INNER JOIN pdv.tipocancelamento tc ON vi.id_tipocancelamento = tc.id
INNER JOIN loja l ON v.id_loja = l.id
INNER JOIN operador_venda opv ON opv.id = v.id
WHERE vi.cancelado = TRUE
  AND v.data BETWEEN '2023-09-01' AND '2023-09-30';
