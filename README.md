# Documentação do aplicativo: Redes Confeitarias

## Introdução

Este projeto é um aplicativo que tem como objetivo auxiliar no gerenciamento de Confeitarias no Brasil. Nele, é possível cadastrar, editar e excluir lojas e produtos associados à ela. 

## Instalação

### Como instalar e rodar o projeto local no seu computador?

## Arquitetura
### Estrutura de pastas
### BLoC

## Banco de Dados

O banco de dados escolhido para este projeto foi o PostgreSQL, pois por ser um banco relacional, vai ajudar no relacionamento entre tabelas de lojas e produtos.

### Queries:

#### Tabela de Loja:
```
CREATE TABLE stores (
  id SERIAL PRIMARY KEY,
  storeName VARCHAR(100) NOT NULL,
  phone VARCHAR(20),
  cep VARCHAR(10),
  latitude VARCHAR(20),
  longitude VARCHAR(20),
  city VARCHAR(50),
  state VARCHAR(2),
  address VARCHAR(100)
);

```

#### Tabela de produtos
```
CREATE TABLE products (
  id SERIAL PRIMARY KEY,
  store_id INTEGER REFERENCES stores(id) ON DELETE CASCADE,
  productName VARCHAR(100) NOT NULL,
  price NUMERIC(10,2) NOT NULL,
  description TEXT
);

```

## Backend

Para a criação do backend, foi criada uma API, dentro do projeto utilizando dart como linguagem.

### Métodos de requisições/resposta:

**GET /stores**

Detalhamento de todas as lojas cadastradas.

- Exemplo de Resposta:

```
[
    {
        id: '1',
        storeName: 'Loja 1',
        cep: '12345678',
        coordenates: ['123456789', '789456123'],
    },
     {
        id: '2',
        storeName: 'Loja 2',
        cep: '78945612',
        coordenates: ['3211212123', '1231321423'],
    },
     {
        id: '1',
        storeName: 'Loja 1',
        cep: '33231215',
        coordenates: ['451231564', '584651213'],
    },
]

```
**GET /store**

Detalhamento de uma loja específica com seus produtos relacionados.

- Exemplo de Resposta:

```
{
    id: '1',
    storeName: 'Loja 1',
    phone: '994561234'
    cep: '12345678',
    coordenates: ['123456789', '789456123'],
    products: [
        {
            id: '1',
            store_id: '1',
            productName: 'Bolo de chocolate',
            price: 39.90
            description: 'Bolo de chocolate de 1kg molhado, redondo, recheado com morango e creme de chocolate branco, com cobertura de chocolate 70%.'
        },
            {
            id: '2',
            store_id: '1',
            productName: 'Brownie',
            price: 19.90
            description: 'Brownie feito com chocolate 80%,      açúcar, manteiga, chocolate, farinha e ovo. Tradicional da França com casquinha crocante e massa cremosa por dentro.'
        },
    ]
}
```
**GET /product:id**

Detalhamento de um produto específico por meio de um 'id'.

- Exemplo de Resposta:

```
{
    id: '1',
    store_id: '1',
    productName: 'Bolo de chocolate',
    price: 39.90
    description: 'Bolo de chocolate de 1kg molhado, redondo, recheado com morango e creme de chocolate branco, com cobertura de chocolate 70%.'
},

```

**POST /store**

Cadastro de uma loja.

- Exemplo de requisição:

```
{
    storeName: 'Confeitaria JJ',
    phone: '995456123',
    cep: '12345678',
    coordenates: ['123456789', '789456123'],
}

```

- Exemplo de resposta: 

```
{
    id: '1',
    storeName: 'Confeitaria JJ',
    phone: '995456123',
    cep: '12345678',
    coordenates: ['123456789', '789456123'],
}

```

**POST /product**

Cadastro de um produto pertencente a uma loja.

- Exemplo de requisição:

```
{
    store_id: '1',
    productName: 'Bolo de chocolate',
    price: 39.90
    description: 'Bolo de chocolate de 1kg molhado, redondo, recheado com morango e creme de chocolate branco, com cobertura de chocolate 70%.'
},

```

- Exemplo de resposta: 

```
{
    id: '1',
    store_id: '1',
    productName: 'Bolo de chocolate',
    price: 39.90
    description: 'Bolo de chocolate de 1kg molhado, redondo, recheado com morango e creme de chocolate branco, com cobertura de chocolate 70%.'
},

```

**PUT /store/:id**

Atualização de uma loja informando o id no path.

- Exemplo de requisição:

```
{
    storeName: 'Confeitaria JJ Atualizada',
    phone: '995456123',
    cep: '12345678',
    coordenates: ['123456789', '789456123'],
}

```

- Exemplo de resposta: 

```
{
    id: '1',
    storeName: 'Confeitaria JJ Atualizada',
    phone: '995456123',
    cep: '12345678',
    coordenates: ['123456789', '789456123'],
}

```

**PUT /product/:id**

Atualização de um produto pertencente a uma loja informando o id no path.

- Exemplo de requisição:

```
{
    productName: 'Bolo de chocolate Atualizado',
    price: 39.90
    description: 'Bolo de chocolate de 1kg molhado, redondo, recheado com morango e creme de chocolate branco, com cobertura de chocolate 70%.'
},

```

- Exemplo de resposta: 

```
{
    id: '1',
    store_id: '1',
    productName: 'Bolo de chocolate Atualizado',
    price: 39.90
    description: 'Bolo de chocolate de 1kg molhado, redondo, recheado com morango e creme de chocolate branco, com cobertura de chocolate 70%.'
},

```

**DELETE /store/:id**

Deletar uma loja informando o id no path.

- Exemplo de resposta: 
Mensagem de Sucesso/ Erro

```
{
    mensagem: 'Confeitaria excluida com sucesso'
}
```
```
{
    erro: 'Não foi possível excluir Confeitaria'
}
```
**DELETE /product/:id**

Deletar um produto informando o id no path.
- Exemplo de resposta: 
Mensagem de Sucesso/ Erro

```
{
    mensagem: 'Confeitaria excluida com sucesso'
}
```
```
{
    erro: 'Não foi possível excluir Confeitaria'
}
```