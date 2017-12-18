DROP TABLE IF EXISTS transactions;
DROP TABLE IF EXISTS tags;
DROP TABLE IF EXISTS merchants;
DROP TABLE IF EXISTS account_settings;

CREATE TABLE merchants (
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(255) UNIQUE
);

CREATE TABLE tags (
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(255)
);

CREATE TABLE account_settings (
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(255),
  budget_limit NUMERIC(8,2) NOT NULL
);

CREATE TABLE transactions (
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(255),
  value INT4,
  transaction_date DATE NOT NULL DEFAULT CURRENT_DATE,
  merchant_id INT4 REFERENCES merchants(id) ON DELETE CASCADE,
  tag_id INT4 REFERENCES tags(id) ON DELETE CASCADE
);
