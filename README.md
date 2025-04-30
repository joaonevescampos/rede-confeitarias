# Documentação do aplicativo: Redes Confeitarias

## Introdução

Este projeto é um aplicativo que tem como objetivo auxiliar no gerenciamento de Confeitarias no Brasil. Nele, é possível cadastrar, editar e excluir lojas e produtos associados à ela. 

## IMPORTANTE - Minhas considerações
Ao criar este projeto, não tinha nenhuma noção de Flutter nem Dart. Ao ser chamado para fazer o teste Técnico, fiquei muito feliz pois é minha chance de demonstrar minhas habilidades e capacidade de aprender em pouco tempo e evoluir como profissional.

Consegui montar um frontend consistente e funcional. No entanto, na parte de integração com banco de dados eu acabei tendo bastante dificuldade, pois comecei criando um banckend completo com Dart e PostgreSQL e depois lembrei que tinha que criar com Drift/ SQLite. Não deu para concluir a integração de alguns endpoints, então o app não está totalmente funcional visto que tive pouco tempo para aprender tudo e entregar algo satisfatório. 

Peço que analise meu projeto levando em consideração que parti do zero em Flutter e consegui apresentar ao menos um frontend consistente. Tenho certeza que com mais tempo conseguiria desenvolver um app bem mais funcional e integrado. Deixarei a pasta de backend e a pasta blocs que criei a título de curiosidade, pois acabei não usando elas.

Portanto, espero que goste do resultado até o momento :)


## Instalação

# Como instalar e rodar o app

## Pré-requisitos

Antes de começar, certifique-se de ter as ferramentas necessárias instaladas em sua máquina:

- **Flutter SDK**: Para compilar e rodar o projeto Flutter.
- **Editor de código**: Como **VSCode** ou **Android Studio**.
- **Emulador ou dispositivo físico**: Para testar o aplicativo.

## Passos para rodar o projeto no seu computador

### 1. Clonar o repositório

Abra o terminal e navegue até o diretório onde deseja clonar o repositório. Use o comando abaixo para clonar o projeto:

```bash
git clone https://github.com/seu-usuario/nome-do-repositorio.git
```

Substitua seu-usuario e nome-do-repositorio pelo seu nome de usuário do GitHub e o nome do repositório correspondente.

### 2. Navegar para o diretório do projeto
Após clonar o repositório, entre na pasta do projeto:
```
cd nome-do-repositorio
```
### 3. Instalar as dependências do Flutter
Dentro do diretório do projeto, instale todas as dependências necessárias utilizando o comando:

```
flutter pub get

```
### 4. Verificar se o projeto está pronto para rodar
Verifique se todas as dependências e configurações estão corretas:
```
flutter doctor

```
Esse comando verifica se há problemas com a instalação do Flutter, Android Studio, ou emuladores. Se houver algum erro, siga as instruções fornecidas no terminal para corrigir.

### 5. Rodar o projeto no emulador ou dispositivo físico
Se você já configurou um emulador Android ou iOS, ou conectou um dispositivo físico, pode rodar o projeto com o comando:
```
flutter run

```
Pronto! Seu projeto  já irá rodar normalmente e poderá testá-lo tanto no próprio VSCode, ou usando seu celular, conectando-o ao computador via UsB. Lembre de selecionar seu dispositivo e ativar o comode desenvolvedor nas configurações do seu celular.

## Estrutura de pastas
![alt text](/lib/assets/images/image.png)

Na pasta lib/presentation fica o frontend da aplicação, lib/components são os widgets reutilizáveis, lib/core são as configurações de tema do app, lib/db conexão do banco de dados, lib/models são os modelos de dados das tabelas stores e products, repositories são responsáveis pela comunicação entre a camada de dados e a camada de negócios da aplicação, e o lib/services são serviços de funções reutilizáveis.

## Design
![alt text](/lib/assets/images/image-1.png)
Todo design foi pensado e executado de forma a garantir facilidade ao usuário sem abrir mão da beleza. Foi criado todo design no Figma, onde é possível ver por meio deste link:

https://www.figma.com/design/1gaJ4eDCLHtCSpMotuywV7/confeitaria?node-id=0-1&m=dev&t=f8OraTMFj0crwn7R-1

## Banco de Dados

A título de curiosidade, iniciamente criei um backend com banco online sem ser com Drift. Não quis simplesmente apagar o que fiz, tanto o código como a documentação.
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
		"id": 1,
		"store_name": "Confeitaria JJ",
		"phone": "995456123",
		"cep": "01310100",
		"latitude": "-23.550520",
		"longitude": "-46.633308",
		"city": "João Pessoa",
		"uf": "PB",
		"address": "Casa da mãe Joana"
	},
	{
		"id": 2,
		"store_name": "Confeitaria 2",
		"phone": "995456123",
		"cep": "01310100",
		"latitude": "-23.550520",
		"longitude": "-46.633308",
		"city": "João Pessoa",
		"uf": "PB",
		"address": "Casa da mãe Joana"
	}
]

```
**GET /store**

Detalhamento de uma loja específica com seus produtos relacionados.

- Exemplo de Resposta:

```
{
  "id": 1,
  "storeName": "Loja 1",
  "phone": "994561234",
  "cep": "12345678",
  "coordenates": ["123456789", "789456123"],
  "products": [
    {
      "id": "1",
      "store_id": "1",
      "productName": "Bolo de chocolate",
      "price": 39.90,
      "description": "Bolo de chocolate de 1kg molhado, redondo, recheado com morango e creme de chocolate branco, com cobertura de chocolate 70%."
    },
    {
      "id": "2",
      "store_id": "1",
      "productName": "Brownie",
      "price": 19.90,
      "description": "Brownie feito com chocolate 80%, açúcar, manteiga, chocolate, farinha e ovo. Tradicional da França com casquinha crocante e massa cremosa por dentro."
    }
  ]
}

```
**GET /product:id**

Detalhamento de um produto específico por meio de um 'id'.

- Exemplo de Resposta:

```
{
  "id": "1",
  "store_id": "1",
  "productName": "Bolo de chocolate",
  "price": 39.90,
  "description": "Bolo de chocolate de 1kg molhado, redondo, recheado com morango e creme de chocolate branco, com cobertura de chocolate 70%."
}


```

**POST /store**

Cadastro de uma loja.

- Exemplo de requisição:

```
{
  "store_name": "Confeitaria JJ",
  "phone": "995456123",
  "cep": "01310100",
  "latitude": -23.550520,
  "longitude": -46.633308,
  "city": "João Pessoa",
  "uf": "PB",
  "address": "Casa da mãe Joana"
}


```

- Exemplo de resposta: 

```
{
	"mensagem": "Loja atualizada com sucesso!"
}

```

**POST /product**

Cadastro de um produto pertencente a uma loja.

- Exemplo de requisição:

```
{
  "store_id": "1",
  "productName": "Bolo de chocolate",
  "price": 39.90,
  "description": "Bolo de chocolate de 1kg molhado, redondo, recheado com morango e creme de chocolate branco, com cobertura de chocolate 70%."
}


```

- Exemplo de resposta: 

```
{
  "id": "1",
  "store_id": "1",
  "productName": "Bolo de chocolate",
  "price": 39.90,
  "description": "Bolo de chocolate de 1kg molhado, redondo, recheado com morango e creme de chocolate branco, com cobertura de chocolate 70%."
}

```

**PUT /store/:id**

Atualização de uma loja informando o id no path.

- Exemplo de requisição:

```
{
  "store_name": "Confeitaria Atualizado",
  "phone": "995456123",
  "cep": "01310100",
  "latitude": "-23.550520",
  "longitude": "-46.633308",
  "city": "João Pessoa",
  "uf": "PB",
  "address": "Casa da mãe Joana"
}


```

- Exemplo de resposta: 

```
{
	"mensagem": "Loja atualizada com sucesso!"
}

```

**PUT /product/:id**

Atualização de um produto pertencente a uma loja informando o id no path.

- Exemplo de requisição:

```
{
  "productName": "Bolo de chocolate Atualizado",
  "price": 39.90,
  "description": "Bolo de chocolate de 1kg molhado, redondo, recheado com morango e creme de chocolate branco, com cobertura de chocolate 70%."
}


```

- Exemplo de resposta: 

```
{
  "id": "1",
  "store_id": "1",
  "productName": "Bolo de chocolate Atualizado",
  "price": 39.90,
  "description": "Bolo de chocolate de 1kg molhado, redondo, recheado com morango e creme de chocolate branco, com cobertura de chocolate 70%."
}


```

**DELETE /store/:id**

Deletar uma loja informando o id no path.

- Exemplo de resposta: 
Mensagem de Sucesso/ Erro

```
{
  "mensagem": "Confeitaria excluída com sucesso"
}

```
```
{
  "erro": "Não foi possível excluir Confeitaria"
}

```
**DELETE /product/:id**

Deletar um produto informando o id no path.
- Exemplo de resposta: 
Mensagem de Sucesso/ Erro

```
{
  "mensagem": "Produto excluído com sucesso"
}

```
```
{
  "erro": "Não foi possível excluir Produto"
}

```