DROP TABLE IF EXISTS transactions;
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS users;


CREATE TABLE categories (
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(255) UNIQUE,
  luxury boolean DEFAULT false
);

CREATE TABLE users (
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(255),
  annual_income NUMERIC(8,2) NOT NULL,
  password VARCHAR(255) NOT NULL
  -- time_period_start DATE NOT NULL DEFAULT CURRENT_DATE,
  -- time_period_end DATE NOT NULL
);

CREATE TABLE transactions (
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(255),
  value NUMERIC(8,2) NOT NULL,
  transaction_date DATE NOT NULL DEFAULT CURRENT_DATE,
  merchant VARCHAR(255),
  category_id INT4 REFERENCES categories(id) ON DELETE CASCADE,
  account_id INT4 REFERENCES users(id) ON DELETE CASCADE
);
