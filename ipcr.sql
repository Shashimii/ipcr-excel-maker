-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 30, 2025 at 02:37 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ipcr`
--

-- --------------------------------------------------------

--
-- Table structure for table `assigned_duties`
--

CREATE TABLE `assigned_duties` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `officer_id` bigint(20) UNSIGNED NOT NULL,
  `duty_id` bigint(20) UNSIGNED NOT NULL,
  `officer_index` int(11) NOT NULL,
  `duty_index` int(11) NOT NULL,
  `officer` varchar(255) NOT NULL,
  `duty` varchar(255) NOT NULL,
  `code` varchar(255) NOT NULL,
  `date` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `assigned_duties`
--

INSERT INTO `assigned_duties` (`id`, `officer_id`, `duty_id`, `officer_index`, `duty_index`, `officer`, `duty`, `code`, `date`, `created_at`, `updated_at`) VALUES
(6, 7, 6, 6, 5, 'Prof. Kane Tremblay DVM', 'Nam sunt temporibus excepturi necessitatibus quisquam aut reprehenderit quidem.', '(12121)', '01/13/2025', '2025-01-29 08:05:56', '2025-01-29 08:05:56'),
(7, 1, 1, 0, 0, 'Keyon Block', 'Ratione quo possimus sint sint voluptatem fuga.', '(12121)', '01/16/2025', '2025-01-29 10:51:14', '2025-01-29 10:51:14'),
(8, 1, 2, 0, 1, 'Keyon Block', 'Dolore quia voluptatem vero voluptas at est.', '(12121)', '01/28/2025', '2025-01-29 10:51:21', '2025-01-29 10:51:21'),
(9, 1, 1, 0, 0, 'Keyon Block', 'Ratione quo possimus sint sint voluptatem fuga.', '(12121)', '01/31/2025', '2025-01-29 10:51:31', '2025-01-29 10:51:31'),
(10, 1, 1, 0, 0, 'Keyon Block', 'Ratione quo possimus sint sint voluptatem fuga.', '(9898)', '01/31/2025', '2025-01-29 10:55:03', '2025-01-29 10:55:03');

-- --------------------------------------------------------

--
-- Table structure for table `duties`
--

CREATE TABLE `duties` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `duties`
--

INSERT INTO `duties` (`id`, `title`, `created_at`, `updated_at`) VALUES
(1, 'Ratione quo possimus sint sint voluptatem fuga.', '2025-01-29 03:26:27', '2025-01-29 03:26:27'),
(2, 'Dolore quia voluptatem vero voluptas at est.', '2025-01-29 03:26:27', '2025-01-29 03:26:27'),
(3, 'Porro occaecati voluptates voluptatem autem vel impedit.', '2025-01-29 03:26:27', '2025-01-29 03:26:27'),
(4, 'Nostrum repellendus earum voluptatibus aliquam dolore consectetur sapiente.', '2025-01-29 03:26:27', '2025-01-29 03:26:27'),
(5, 'Voluptates dolores voluptate sit adipisci sint.', '2025-01-29 03:26:27', '2025-01-29 03:26:27'),
(6, 'Nam sunt temporibus excepturi necessitatibus quisquam aut reprehenderit quidem.', '2025-01-29 03:26:27', '2025-01-29 03:26:27'),
(7, 'Voluptates repellendus deserunt dolores deserunt.', '2025-01-29 03:26:27', '2025-01-29 03:26:27');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_reset_tokens_table', 1),
(3, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(4, '2025_01_22_123042_create_officers_table', 1),
(5, '2025_01_22_130202_create_duties_table', 1),
(6, '2025_01_22_144342_create_assigned_duties_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `officers`
--

CREATE TABLE `officers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `officers`
--

INSERT INTO `officers` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'Keyon Block', '2025-01-29 03:26:27', '2025-01-29 03:26:27'),
(2, 'Immanuel Ernser', '2025-01-29 03:26:27', '2025-01-29 03:26:27'),
(3, 'Lorenza Reilly', '2025-01-29 03:26:27', '2025-01-29 03:26:27'),
(4, 'Maverick Bailey', '2025-01-29 03:26:27', '2025-01-29 03:26:27'),
(5, 'Dillon Greenfelder', '2025-01-29 03:26:27', '2025-01-29 03:26:27'),
(6, 'Hanna Gaylord II', '2025-01-29 03:26:27', '2025-01-29 03:26:27'),
(7, 'Prof. Kane Tremblay DVM', '2025-01-29 03:26:27', '2025-01-29 03:26:27'),
(8, 'Ena Hermann', '2025-01-29 03:26:27', '2025-01-29 03:26:27'),
(9, 'Dr. Rubye Kris Sr.', '2025-01-29 03:26:27', '2025-01-29 03:26:27'),
(10, 'Dr. Yadira Heller DVM', '2025-01-29 03:26:27', '2025-01-29 03:26:27');

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `personal_access_tokens`
--

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(1, 'App\\Models\\User', 1, 'authToken', '384ce39d1c1991eae31df70f0877cc9890663b7400254351b8c219ece581c37e', '[\"*\"]', NULL, NULL, '2025-01-29 03:37:53', '2025-01-29 03:37:53'),
(2, 'App\\Models\\User', 1, 'authToken', 'e917afb0b3277b2160f1a1a3987fce45ce91fd1e358cfeece034aba67fec66ac', '[\"*\"]', NULL, NULL, '2025-01-29 03:42:02', '2025-01-29 03:42:02'),
(3, 'App\\Models\\User', 1, 'authToken', '6b626a379d8cbc5c78570a2fe74e2a56c946f8a3b7639e8a692ab05dbf939c43', '[\"*\"]', NULL, NULL, '2025-01-29 03:42:39', '2025-01-29 03:42:39'),
(4, 'App\\Models\\User', 1, 'authToken', '5a7e35f4c4fdcd4d816ea4cd33b1d916a0445161db6f2f1e63742b8771691240', '[\"*\"]', NULL, NULL, '2025-01-29 03:43:21', '2025-01-29 03:43:21'),
(5, 'App\\Models\\User', 1, 'authToken', '878919c53a252e90a77b490aec3e4465b6ab7ea9797bdc4823cbc357ae072ba6', '[\"*\"]', '2025-01-29 03:52:15', NULL, '2025-01-29 03:44:20', '2025-01-29 03:52:15');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Admin1000', '$2y$12$m38Qnwm.5QtGQrLCCBlh9.H.4hK0YLBk4690WizpUHpwb22FtSPyu', NULL, '2025-01-29 03:26:27', '2025-01-29 09:44:27');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `assigned_duties`
--
ALTER TABLE `assigned_duties`
  ADD PRIMARY KEY (`id`),
  ADD KEY `assigned_duties_officer_id_foreign` (`officer_id`),
  ADD KEY `assigned_duties_duty_id_foreign` (`duty_id`);

--
-- Indexes for table `duties`
--
ALTER TABLE `duties`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `officers`
--
ALTER TABLE `officers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `assigned_duties`
--
ALTER TABLE `assigned_duties`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `duties`
--
ALTER TABLE `duties`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `officers`
--
ALTER TABLE `officers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `assigned_duties`
--
ALTER TABLE `assigned_duties`
  ADD CONSTRAINT `assigned_duties_duty_id_foreign` FOREIGN KEY (`duty_id`) REFERENCES `duties` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `assigned_duties_officer_id_foreign` FOREIGN KEY (`officer_id`) REFERENCES `officers` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
