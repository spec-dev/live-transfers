# Live Transfers

Tracking live token transfers with Spec.

* [Installation](#installation)
* [Setup](#setup)
* [Initialize Spec Project](#initialize-spec-project)
* [Add Live Transfers Table](#add-live-transfers-table)
* [Start Spec](#start-spec)

# Requirements

* Node.js `>= 16`
* npm `>= 8`
* Postgres `>= 14`
* Spec CLI `>= 0.2.2`
* Spec Client `>= 0.0.13`
* An active Spec account

# Installation

```bash
$ npm install -g @spec.dev/cli @spec.dev/spec
```

# Setup 

### 1) Login to your Spec account

```bash
$ spec login
```

### 2) Clone this repo and jump into it

The rest of this workflow will assume you are operating out of this repo as your cwd.

```bash
$ git clone https://github.com/spec-dev/live-transfers && cd live-transfers
```

### 3) Create a new database

If you already have a database with a table of wallets that you want to track transfers for, you can skip this step. Otherwise, to start fresh, just create a new Postgres database:

```bash
$ createdb live-transfers
```

### 4) Add the wallet table with some test wallets

This will create a new `wallet` table in the database with a handful of ethereum wallets for testing.

```bash
$ psql live-transfers -f helpers/wallets.sql
```

# Initialize Spec Project

Every "project" on Spec has its own unique set of API keys, access permissions, and dedicated set of config files that outlines:

1. Which Live Tables you need in your database (with any personalized naming conventions, data mappings, filters, etc.)
2. Which database _environments_ exist in your app's deployment pipeline and how to connect to each (local, staging, prod, etc.)

### 1) Initialize this codebase as a Spec project

```bash
$ spec init
```

If it doesn't exist already, a new `.spec` folder will be created in the root of your project with the following contents:

```
.spec/
|  connect.toml
|  project.toml
```

* `connect.toml` - Specifies the different database environments in your project
* `project.toml` - Specifies which Live Tables you want in your database and their respective data sources/mappings/filters/etc.

### 2) Configure your project's local database environment

Open `connect.toml` and set the `"name"` of the database to `live-transfers`.

**Example:**<br>
```toml
# Local database
[local]
name = 'live-transfers'
port = 5432
host = 'localhost'
user = '<your-db-username>' # should be autopopulated with your current db user
password = '' # might not be needed
```

### 3) Set the local location of your Spec project

> [!NOTE]
> The `gitcoin/spec` project has already been created on Spec with its own set of API credentials 

This next command will do the following 3 things:

1. Pull down your project's API credentials and save them locally (so that you can run Live Tables locally)
2. Set your _current_ project to `gitcoin/spec` (many CLI commands run using the _current_ project context)
3. Tell the Spec CLI where your `gitcoin/spec` project exists locally

```
$ spec link project gitcoin/spec .
```

# Add Live Transfers Table

Now that your Spec project is set up and you have a database with a table of wallets, lets add a new Live Table that represents all token transfers _to or from_ any of those wallets.

### 1) Add the Live Table to your project

This next command will do the following 3 things:

1. Generate the SQL migrations for a `token_transfer` table (inside `.spec/migrations/`)
2. Go ahead and apply those migrations to the database
3. Add the Live Table to your Spec config (`.spec/project.toml`) 

```bash
$ spec add table --from tokens.TokenTransfer --migrate
```

The data "source" for this new Live Table will be Spec's [`tokens.TokenTransfer`](https://spec.dev/tokens/live-object/94aada66-70f5-4785-85b7-88d23b53812d) object. 

### 2) Filter the transfer data _on_ your wallet table

Without filters, the current Spec config would pull _all_ token transfers, which we definitely don't want. So let's add some filters so that only token transfers _to or from_ any of the wallets in the `wallet` table are actually sourced.

Go into your `project.toml`, and in the "Links & Filters" section, add the following filters:

```toml
[[objects.TokenTransfer.links]]
table = 'public.token_transfer'
uniqueBy = [ 'transferId' ]
filterBy = [
	{ fromAddress = { op = '=', column = 'public.wallet.address' }, chainId = { op = '=', column = 'public.wallet.chain_id' } },
	{ toAddress = { op = '=', column = 'public.wallet.address' }, chainId = { op = '=', column = 'public.wallet.chain_id' } },
]
```

# Start Spec

Now that we have a Live Table fully configured, let's run the Spec client against our database.

When Spec starts up, it will...

1. Detect and run any new SQL migrations listed in `.spec/migrations/`
2. Add triggers to any new Live Tables to track DB operations and react to them
3. Backfill any new Live Tables
4. Subscribe to events to keep your tables up-to-date
5. Subscribe to reorgs and automatically course-correct

```bash
$ spec start
```