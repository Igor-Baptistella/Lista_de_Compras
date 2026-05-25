# 🛒 Lista de Compras

Aplicativo mobile desenvolvido em Flutter com integração ao Supabase para autenticação e armazenamento de dados.

O sistema permite que usuários criem uma conta, façam login e gerenciem uma lista de compras pessoal de forma simples e organizada.

---

# Funcionalidades Principais

- Cadastro de usuários
- Login com autenticação
- Logout
- CRUD completo de itens:
  - Adicionar itens
  - Listar itens
  - Editar itens
  - Excluir itens
- Marcar itens como comprados
- Interface dinâmica e responsiva
- Navegação entre telas
- Proteção de rotas para usuários autenticados

---

# Tecnologias Utilizadas

- Flutter
- Dart
- Supabase Authentication
- Supabase Database (PostgreSQL)
- VS Code
- Git e GitHub

---

# Instruções para Executar o Projeto

## 1. Pré-requisitos

Antes de iniciar, é necessário ter instalado na máquina:

- Flutter SDK
- Dart SDK
- VS Code ou Android Studio
- Git
- Android SDK
- Um dispositivo Android físico ou emulador configurado

---

## 2. Clonar o repositório

Abra o terminal e execute:

```bash
git clone https://github.com/Igor-Baptistella/Lista_de_Compras.git
```

---

## 3. Acessar a pasta do projeto

```bash
cd Lista_de_Compras
```

---

## 4. Instalar as dependências

Execute o comando abaixo para baixar todas as bibliotecas utilizadas no projeto:

```bash
flutter pub get
```

---

## 6. Executar o aplicativo

Conecte um celular Android com depuração USB ativada ou inicie um emulador Android.

Depois execute:

```bash
flutter run
```

O aplicativo será compilado e iniciado automaticamente.

---

# Descrição da Autenticação e da Base de Dados

## Autenticação

A autenticação do aplicativo foi desenvolvida utilizando o Supabase Authentication com login por e-mail e senha.

Funcionalidades implementadas:

- Cadastro de novos usuários
- Login de usuários existentes
- Logout
- Proteção de telas autenticadas
- Validação básica de campos
- Tratamento simples de erros de autenticação

Quando o usuário realiza login com sucesso, o Supabase cria uma sessão autenticada, permitindo acesso às funcionalidades internas do aplicativo.

---

## Base de Dados

O banco de dados utilizado é PostgreSQL hospedado no Supabase.

A aplicação utiliza a tabela:

## shopping_items

Responsável por armazenar os itens da lista de compras.

Campos utilizados:

| Campo | Descrição |
|---|---|
| id | Identificador único do item |
| user_id | ID do usuário dono do item |
| name | Nome do item |
| quantity | Quantidade do item |
| checked | Indica se o item foi comprado |
| created_at | Data de criação do item |

---

## Operações realizadas no banco

O sistema implementa CRUD completo:

- CREATE → adicionar itens
- READ → listar itens
- UPDATE → editar itens e marcar como comprado
- DELETE → remover itens

Todos os dados são armazenados online utilizando o Supabase Database.

---

# Autor

Projeto desenvolvido por Igor Baptistella para fins acadêmicos.