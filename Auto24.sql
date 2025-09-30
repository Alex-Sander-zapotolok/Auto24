-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: mariadb
-- Loomise aeg: Sept 30, 2025 kell 08:53 EL
-- Serveri versioon: 12.0.2-MariaDB-ubu2404
-- PHP versioon: 8.2.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Andmebaas: `Auto24`
--

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `transactions`
--

CREATE TABLE `transactions` (
  `Transaction_id` int(11) NOT NULL COMMENT 'Unique Transaction ID',
  `User_id` int(11) NOT NULL COMMENT 'User ID',
  `Amount` decimal(10,2) NOT NULL COMMENT 'Transaction Amount',
  `Currency` varchar(3) NOT NULL COMMENT 'Currency',
  `Transaction_type` ENUM('payment' , 'refund' , 'transfer') NOT NULL COMMENT 'Transaction Type',
  `Status` ENUM('PENDING' , 'PAID' , 'FAILED' , 'REFUNDED') NOT NULL COMMENT 'Transaction Status',
  `Created_at` timestamp NOT NULL DEFAULT current_timestamp() COMMENT 'Transaction Creation Date',
  `Updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT 'Last Date Of Update'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci COMMENT='transactions';

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `users`
--

CREATE TABLE `users` (
  `ID` int(11) NOT NULL COMMENT 'User Unique Identification',
  `Username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Username',
  `Email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'E-mail Address',
  UNIQUE KEY 'uk_users_username' ('Username'),
  UNIQUE KEY 'uk_users_email' ('Email')
  `Password_hash` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Hash Password',
  `Create_at` timestamp NOT NULL DEFAULT current_timestamp() COMMENT 'Date Of Creation',
  `Update_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT 'Last Updated',
  `Is_active` tinyint(1) NOT NULL DEFAULT 1 COMMENT 'User Activity Status',
  `Role` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'User Role'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci COMMENT='users';

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `vehicles`
--

CREATE TABLE `vehicles` (
  `ID` int(10) UNSIGNED NOT NULL,
  `Brand` varchar(100) NOT NULL,
  `Model` varchar(100) NOT NULL,
  `year` smallint UNSIGNED NOT NULL CHECK ('year' BETWEEN 1800 AND 2099),
  `price` decimal(10,2) NOT NULL,
  `description` text DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  `contact_name` varchar(100) DEFAULT NULL,
  `contact_phone` varchar(20) DEFAULT NULL,
  `contact_email` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE 'vehicle_images' (
  'id' int(11) NOT NULL AUTO_INCREMENT,
  'vehicle_id' int(10) UNSIGNED NOT NULL,
  'image_url' varchar(255) NOT NULL,
  'sort_order' int(11) DEFAULT 0,
  'is_visible' tinyint(1) DEFAULT 1,
  PRIMARY KEY ('id')
  KEY 'idx_vehicle_id' ('vehicle_id'),
  CONSTRAINT 'fk_vehicle_images_vehicle' FOREIGN KEY ('vehicle_id') REFERENCES
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

--
-- Indeksid tõmmistatud tabelitele
--

--
-- Indeksid tabelile `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`Transaction_id`);

--
-- Indeksid tabelile `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`ID`);

--
-- Indeksid tabelile `vehicles`
--
ALTER TABLE `vehicles`
  ADD PRIMARY KEY (`ID`);

--
-- AUTO_INCREMENT tõmmistatud tabelitele
--

--
-- AUTO_INCREMENT tabelile `transactions`
--
ALTER TABLE `transactions`
  MODIFY `Transaction_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique Transaction ID';

--
-- AUTO_INCREMENT tabelile `users`
--
ALTER TABLE `users`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'User Unique Identification';

--
-- AUTO_INCREMENT tabelile `vehicles`
--
ALTER TABLE `vehicles`
  MODIFY `ID` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
