# Projeto Prático ETL com Apache Hop

## 📋 Descrição do Projeto

Este é um projeto prático completo de ETL (Extract, Transform, Load) utilizando Apache Hop e PostgreSQL. O projeto demonstra:

- Extração de dados de arquivos CSV
- Transformações e agregações de dados
- Carga de dados refinados no PostgreSQL (Data Warehouse)
- Leitura, transformação e recarga de dados do DW

## 🗂️ Estrutura do Projeto

```
Aula02_ETL-ELT/
│
├── projeto_etl_apache_hop.html    # Guia completo do projeto (ABRA ESTE ARQUIVO)
├── vendas.csv                     # Dados de vendas
├── produtos.csv                   # Dados de produtos
├── clientes.csv                   # Dados de clientes
├── scripts_postgresql.sql         # Scripts SQL para criar o DW
└── README.md                      # Este arquivo
```

## 🚀 Como Usar Este Projeto

### 1️⃣ Abrir o Guia do Projeto

Abra o arquivo **`projeto_etl_apache_hop.html`** em seu navegador. Este arquivo contém:

- Visão geral completa do projeto
- Instruções passo a passo detalhadas
- Configurações de todas as pipelines e workflows
- Scripts SQL
- Dicas e boas práticas

### 2️⃣ Preparar os Dados

Os arquivos CSV já estão incluídos neste diretório:
- `vendas.csv`
- `produtos.csv`
- `clientes.csv`

**Opção A:** Copie esses arquivos para `C:\dados\fonte\` (conforme o guia HTML)

**Opção B:** Modifique os caminhos nas pipelines do Apache Hop para apontar para este diretório

### 3️⃣ Configurar o PostgreSQL

Execute os scripts do arquivo `scripts_postgresql.sql` no PostgreSQL para:
- Criar o database `dw_vendas`
- Criar as tabelas necessárias
- Adicionar campos para refinamento

### 4️⃣ Seguir o Guia HTML

Siga o guia passo a passo no arquivo HTML para:
1. Criar as conexões no Apache Hop
2. Criar a Pipeline 1: Extração e Carga Inicial
3. Criar a Pipeline 2: Agregações e Análises
4. Criar o Workflow: Orquestrando as Pipelines
5. Criar a Pipeline 3: Leitura e Novo Refinamento

## 📊 Dados do Projeto

### Vendas
- 12 transações de vendas
- Período: Janeiro 2024
- Campos: id_venda, data_venda, id_produto, quantidade, preco_unitario, id_cliente, id_vendedor

### Produtos
- 5 produtos de informática
- Campos: id_produto, nome_produto, categoria, fornecedor

### Clientes
- 7 clientes
- Campos: id_cliente, nome_cliente, cidade, estado, segmento

## 🎯 Objetivos de Aprendizado

Ao completar este projeto, você terá aprendido:

✅ Como extrair dados de arquivos CSV no Apache Hop  
✅ Como fazer joins entre diferentes fontes de dados  
✅ Como realizar cálculos e transformações  
✅ Como criar agregações (GROUP BY, SUM, COUNT, AVG)  
✅ Como usar fórmulas condicionais  
✅ Como carregar dados no PostgreSQL  
✅ Como ler dados do DW e fazer refinamentos  
✅ Como orquestrar pipelines usando workflows  
✅ Como validar e verificar dados no DW  

## 🛠️ Tecnologias Utilizadas

- **Apache Hop**: Ferramenta de ETL/ELT
- **PostgreSQL**: Data Warehouse
- **CSV**: Formato de arquivos fonte

## 📝 Notas Importantes

- Os arquivos fonte CSV já contêm dados alinhados com as transformações solicitadas
- Todos os transforms e steps mencionados existem no Apache Hop
- O projeto pode ser executado em ambiente Windows
- Não são necessárias instalações adicionais além do Apache Hop e PostgreSQL

## 🔗 Fluxo do Projeto

```
CSV Files → Pipeline 1 → DW (vendas_refinadas)
                            ↓
                       Pipeline 2 → DW (tabelas agregadas)
                            ↓
DW (vendas_refinadas) → Pipeline 3 → DW (vendas_refinadas atualizada)
```

## 📚 Recursos Adicionais

- [Documentação Apache Hop](https://hop.apache.org/manual/latest/)
- [PostgreSQL Documentation](https://www.postgresql.org/docs/)

## 💡 Suporte

Para dúvidas:
1. Consulte o guia HTML detalhado
2. Verifique os comentários nos scripts SQL
3. Revise a seção "Dicas e Boas Práticas" no HTML

---

**Desenvolvido para a disciplina de Engenharia de Dados**  
*Aula 02: ETL/ELT com Apache Hop*

