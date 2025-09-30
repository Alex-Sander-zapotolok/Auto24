-- phpMyAdmin SQL Dump
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

/*!40101 SET NAMES utf8mb4 */;

-- --------------------------------------------------------
-- Tabel: makes
-- --------------------------------------------------------
CREATE TABLE `makes` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

ALTER TABLE `makes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

ALTER TABLE `makes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- --------------------------------------------------------
-- Tabel: models
-- --------------------------------------------------------
CREATE TABLE `models` (
  `id` int(11) NOT NULL,
  `make_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `vin` varchar(17) DEFAULT NULL,
  `year` smallint(5) UNSIGNED NOT NULL CHECK (`year` BETWEEN 1800 AND 2099),
  `price` decimal(10,2) NOT NULL,
  `description` text DEFAULT NULL,
  `engine` varchar(50) DEFAULT NULL,
  `mileage` int(11) DEFAULT NULL,
  `fuel_type` enum('Petrol','Diesel','Electric','Hybrid','Other') DEFAULT NULL,
  `transmission` enum('Manual','Automatic','Semi-Auto') DEFAULT NULL,
  `doors` tinyint(4) DEFAULT NULL,
  `seats` tinyint(4) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

ALTER TABLE `models`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `vin` (`vin`),
  ADD KEY `idx_models_make_id` (`make_id`);

ALTER TABLE `models`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- Võõrvõti make → models
ALTER TABLE `models`
  ADD CONSTRAINT `fk_models_makes` FOREIGN KEY (`make_id`) REFERENCES `makes`(`id`) ON DELETE CASCADE;

-- --------------------------------------------------------
-- Tabel: vehicles
-- --------------------------------------------------------
CREATE TABLE `vehicles` (
  `ID` int(10) UNSIGNED NOT NULL,
  `model_id` int(11) NOT NULL,  -- lisame mudeli viite
  `year` year(4) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `description` text DEFAULT NULL,
  `images` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  `contact_name` varchar(100) DEFAULT NULL,
  `contact_phone` varchar(20) DEFAULT NULL,
  `contact_email` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

ALTER TABLE `vehicles`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `idx_vehicles_model_id` (`model_id`);

ALTER TABLE `vehicles`
  MODIFY `ID` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

-- Võõrvõti vehicles → models
ALTER TABLE `vehicles`
  ADD CONSTRAINT `fk_vehicles_models` FOREIGN KEY (`model_id`) REFERENCES `models`(`id`) ON DELETE RESTRICT;

-- --------------------------------------------------------
-- Tabel: users
-- --------------------------------------------------------
CREATE TABLE `users` (
  `ID` int(11) NOT NULL COMMENT 'User Unique Identification',
  `Username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Username',
  `Email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'E-mail Address',
  `Password_hash` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Hash Password',
  `Create_at` timestamp NOT NULL DEFAULT current_timestamp() COMMENT 'Date Of Creation',
  `Update_at` timestamp NOT NULL DEFAULT current_timestamp() COMMENT 'Last Updated',
  `Is_active` tinyint(1) NOT NULL COMMENT 'User Activity Status',
  `Role` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'User Role'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci COMMENT='users';

ALTER TABLE `users`
  ADD PRIMARY KEY (`ID`);

ALTER TABLE `users`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'User Unique Identification';

COMMIT;
