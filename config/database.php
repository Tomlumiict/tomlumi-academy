<?php
/**
 * Tomlumi Academy Database Connection
 * Establishes MySQLi connection with error handling
 */

class Database {
    private $connection;
    private $host = DB_HOST;
    private $db_name = DB_NAME;
    private $user = DB_USER;
    private $pass = DB_PASS;
    private $port = DB_PORT;

    public function connect() {
        $this->connection = new mysqli(
            $this->host,
            $this->user,
            $this->pass,
            $this->db_name,
            $this->port
        );

        // Check connection
        if ($this->connection->connect_error) {
            die('Database Connection Error: ' . $this->connection->connect_error);
        }

        // Set charset
        $this->connection->set_charset('utf8mb4');

        return $this->connection;
    }

    public function getConnection() {
        return $this->connection;
    }

    public function close() {
        if ($this->connection) {
            $this->connection->close();
        }
    }
}

// Create global database instance
$db = new Database();
$conn = $db->connect();

if (!$conn) {
    die('Unable to connect to database. Please check your configuration.');
}
