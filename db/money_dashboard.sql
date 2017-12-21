DROP TABLE IF EXISTS transactions;
DROP TABLE IF EXISTS tags;
DROP TABLE IF EXISTS merchants;
DROP TABLE IF EXISTS users;

CREATE TABLE merchants (
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(255) UNIQUE
);

CREATE TABLE tags (
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(255) UNIQUE,
  luxury boolean DEFAULT false
);

CREATE TABLE users (
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(255),
  annual_income NUMERIC(8,2) NOT NULL
  -- time_period_start DATE NOT NULL DEFAULT CURRENT_DATE,
  -- time_period_end DATE NOT NULL
);

CREATE TABLE transactions (
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(255),
  value NUMERIC(8,2) NOT NULL,
  transaction_date DATE NOT NULL DEFAULT CURRENT_DATE,
  merchant_id INT4 REFERENCES merchants(id) ON DELETE CASCADE,
  tag_id INT4 REFERENCES tags(id) ON DELETE CASCADE,
  account_id INT4 REFERENCES users(id) ON DELETE CASCADE
);
