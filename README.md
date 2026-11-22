# MoonStone Eshop 🛒

A full-stack e-commerce application developed as part of a university database course. The project combines a web-based storefront, an interactive command-line interface (CLI), and a relational MySQL database to manage products, customers, orders, and inventory.

## Features

- **Product Management:** Create, view, update, and delete products.
- **Product Categories:** Organize and browse products by category.
- **Customer Management:** Store and manage customer information.
- **Order Management:** Create orders, add products to orders, and manage order information.
- **Inventory Management:** Track stock quantities and product storage locations.
- **Order Fulfillment:** Generate picking lists and manage the shipping process.
- **Command-Line Interface:** Interact with the database through a terminal-based menu.
- **Database Logging:** Track database operations using SQL triggers.

## Technologies Used

- **Backend:** Node.js, Express.js
- **Frontend:** EJS templates, HTML
- **Database:** MySQL
- **Database Integration:** promise-mysql
- **CLI:** JavaScript, readline-sync
- **Version Control:** Git and GitHub

## Database Design

The application uses a relational MySQL database featuring:

- Tables with primary and foreign key relationships
- Stored procedures for database operations
- SQL functions
- Triggers for automated logging
- SQL scripts for database setup and sample data

## Project Structure

```text
eshop/
├── config/db/          # Database configuration
├── middleware/         # Express middleware
├── route/              # Web application routes
├── src/                # Database interaction and application logic
├── sql/eshop/          # Database schema, setup scripts, and sample data
├── views/eshop/        # EJS templates
├── cli.js              # Command-line interface
├── index.js            # Web application entry point
├── package.json        # Project dependencies
└── README.md           # Project documentation
```

## Installation

### Prerequisites

- Node.js and npm
- MySQL

### Setup

1. Clone the repository:

   ```bash
   git clone https://github.com/nayamathbout/moonstone-eshop.git
   cd moonstone-eshop
   ```

2. Install dependencies:

   ```bash
   npm install
   ```

3. Create your database configuration file:

   Copy `config/db/eshop.example.json` to `config/db/eshop.json` and replace the placeholder values with your MySQL connection details.

4. Set up the MySQL database using the SQL scripts in `sql/eshop/`.

### Running the Application

Start the web application:

```bash
node index.js
```

Start the command-line interface:

```bash
node cli.js
```

## About

This project was developed to practice relational database design, SQL programming, and integrating a MySQL database with a JavaScript application through both web and command-line interfaces.