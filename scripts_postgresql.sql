-- ================================================================
-- SCRIPTS SQL PARA CONFIGURAÇÃO DO DATA WAREHOUSE
-- Projeto ETL com Apache Hop
-- ================================================================

-- ----------------------------------------------------------------
-- 1. CRIAR O DATABASE
-- ----------------------------------------------------------------
CREATE DATABASE dw_vendas;

-- Conecte-se ao database dw_vendas antes de executar os próximos comandos

-- ----------------------------------------------------------------
-- 2. TABELA DE VENDAS REFINADAS
-- ----------------------------------------------------------------
CREATE TABLE vendas_refinadas (
    id_venda INTEGER PRIMARY KEY,
    data_venda DATE,
    ano INTEGER,
    mes INTEGER,
    trimestre INTEGER,
    id_produto INTEGER,
    nome_produto VARCHAR(100),
    categoria VARCHAR(50),
    quantidade INTEGER,
    preco_unitario DECIMAL(10,2),
    valor_total DECIMAL(10,2),
    id_cliente INTEGER,
    nome_cliente VARCHAR(100),
    cidade VARCHAR(100),
    estado VARCHAR(2),
    segmento VARCHAR(50),
    id_vendedor INTEGER
);

-- ----------------------------------------------------------------
-- 3. TABELA DE AGREGAÇÃO DE VENDAS POR PRODUTO
-- ----------------------------------------------------------------
CREATE TABLE vendas_por_produto (
    id_produto INTEGER PRIMARY KEY,
    nome_produto VARCHAR(100),
    categoria VARCHAR(50),
    total_quantidade INTEGER,
    total_vendas DECIMAL(12,2),
    numero_transacoes INTEGER,
    ticket_medio DECIMAL(10,2)
);

-- ----------------------------------------------------------------
-- 4. TABELA DE AGREGAÇÃO DE VENDAS POR CLIENTE
-- ----------------------------------------------------------------
CREATE TABLE vendas_por_cliente (
    id_cliente INTEGER PRIMARY KEY,
    nome_cliente VARCHAR(100),
    cidade VARCHAR(100),
    estado VARCHAR(2),
    segmento VARCHAR(50),
    total_compras DECIMAL(12,2),
    numero_pedidos INTEGER,
    ticket_medio DECIMAL(10,2),
    classificacao VARCHAR(20)
);

-- ----------------------------------------------------------------
-- 5. TABELA DE VENDAS MENSAIS
-- ----------------------------------------------------------------
CREATE TABLE vendas_mensais (
    ano INTEGER,
    mes INTEGER,
    total_vendas DECIMAL(12,2),
    total_quantidade INTEGER,
    numero_transacoes INTEGER,
    ticket_medio DECIMAL(10,2),
    PRIMARY KEY (ano, mes)
);

-- ----------------------------------------------------------------
-- 6. ADICIONAR CAMPOS PARA REFINAMENTO ADICIONAL
-- Execute este comando APÓS executar a Pipeline 1
-- ----------------------------------------------------------------
ALTER TABLE vendas_refinadas 
ADD COLUMN lucro_estimado DECIMAL(10,2),
ADD COLUMN receita_liquida DECIMAL(10,2),
ADD COLUMN performance_venda VARCHAR(20);

-- ----------------------------------------------------------------
-- 7. CONSULTAS DE VERIFICAÇÃO
-- ----------------------------------------------------------------

-- Verificar contagem de registros em todas as tabelas
SELECT 'vendas_refinadas' as tabela, COUNT(*) as total FROM vendas_refinadas
UNION ALL
SELECT 'vendas_por_produto', COUNT(*) FROM vendas_por_produto
UNION ALL
SELECT 'vendas_por_cliente', COUNT(*) FROM vendas_por_cliente
UNION ALL
SELECT 'vendas_mensais', COUNT(*) FROM vendas_mensais;

-- Visualizar vendas refinadas
SELECT * FROM vendas_refinadas LIMIT 10;

-- Top produtos por vendas
SELECT 
    nome_produto,
    categoria,
    total_quantidade,
    total_vendas,
    ticket_medio
FROM vendas_por_produto
ORDER BY total_vendas DESC;

-- Clientes VIP
SELECT 
    nome_cliente,
    segmento,
    total_compras,
    numero_pedidos,
    classificacao
FROM vendas_por_cliente
WHERE classificacao = 'VIP'
ORDER BY total_compras DESC;

-- Performance de vendas por mês
SELECT 
    ano,
    mes,
    total_vendas,
    numero_transacoes,
    ticket_medio
FROM vendas_mensais
ORDER BY ano, mes;

-- Vendas com maior performance
SELECT 
    id_venda,
    nome_produto,
    nome_cliente,
    valor_total,
    lucro_estimado,
    receita_liquida,
    performance_venda
FROM vendas_refinadas
WHERE performance_venda = 'Alta'
ORDER BY valor_total DESC;

-- ----------------------------------------------------------------
-- 8. ANÁLISES ADICIONAIS
-- ----------------------------------------------------------------

-- Análise de vendas por segmento de cliente
SELECT 
    v.segmento,
    COUNT(*) as total_transacoes,
    SUM(v.valor_total) as total_vendas,
    AVG(v.valor_total) as ticket_medio,
    SUM(v.quantidade) as total_produtos
FROM vendas_refinadas v
GROUP BY v.segmento
ORDER BY total_vendas DESC;

-- Análise de vendas por estado
SELECT 
    v.estado,
    COUNT(DISTINCT v.id_cliente) as clientes_unicos,
    COUNT(*) as total_transacoes,
    SUM(v.valor_total) as total_vendas
FROM vendas_refinadas v
GROUP BY v.estado
ORDER BY total_vendas DESC;

-- Produtos mais vendidos por categoria
SELECT 
    categoria,
    nome_produto,
    total_quantidade,
    total_vendas,
    numero_transacoes
FROM vendas_por_produto
ORDER BY categoria, total_vendas DESC;

-- Evolução mensal de vendas
SELECT 
    ano,
    mes,
    total_vendas,
    LAG(total_vendas) OVER (ORDER BY ano, mes) as vendas_mes_anterior,
    total_vendas - LAG(total_vendas) OVER (ORDER BY ano, mes) as variacao,
    ROUND(
        ((total_vendas - LAG(total_vendas) OVER (ORDER BY ano, mes)) / 
        NULLIF(LAG(total_vendas) OVER (ORDER BY ano, mes), 0)) * 100, 
        2
    ) as percentual_crescimento
FROM vendas_mensais
ORDER BY ano, mes;

-- ----------------------------------------------------------------
-- 9. LIMPEZA (USE COM CUIDADO)
-- ----------------------------------------------------------------

-- Limpar todas as tabelas (executar apenas se necessário reiniciar)
-- TRUNCATE TABLE vendas_refinadas CASCADE;
-- TRUNCATE TABLE vendas_por_produto CASCADE;
-- TRUNCATE TABLE vendas_por_cliente CASCADE;
-- TRUNCATE TABLE vendas_mensais CASCADE;

-- Remover todas as tabelas (executar apenas se necessário recriar)
-- DROP TABLE IF EXISTS vendas_refinadas CASCADE;
-- DROP TABLE IF EXISTS vendas_por_produto CASCADE;
-- DROP TABLE IF EXISTS vendas_por_cliente CASCADE;
-- DROP TABLE IF EXISTS vendas_mensais CASCADE;

-- ================================================================
-- FIM DOS SCRIPTS
-- ================================================================
