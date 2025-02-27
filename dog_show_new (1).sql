-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 01, 2024 at 10:58 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `dog show new`
--

-- --------------------------------------------------------

--
-- Table structure for table `dogs`
--

CREATE TABLE `dogs` (
  `DOG_ID` int(11) NOT NULL,
  `DNAME` varchar(10) DEFAULT NULL,
  `DAGE` int(11) DEFAULT NULL,
  `DSEX` varchar(1) DEFAULT NULL,
  `DDATE` date DEFAULT NULL,
  `CERT_NO` int(11) DEFAULT NULL,
  `OWNER_ID` int(11) DEFAULT NULL,
  `BREED` varchar(20) NOT NULL
) ;

--
-- Dumping data for table `dogs`
--

INSERT INTO `dogs` (`DOG_ID`, `DNAME`, `DAGE`, `DSEX`, `DDATE`, `CERT_NO`, `OWNER_ID`, `BREED`) VALUES
(77852, 'REX', 5, 'M', '2019-11-02', 78, 25, ''),
(77853, 'BUDDY', 8, 'F', '2016-08-14', 79, 20, ''),
(77854, 'BOB', 2, 'M', '2022-12-25', 80, 30, '');

-- --------------------------------------------------------

--
-- Stand-in structure for view `dogs_details`
-- (See below for the actual view)
--
CREATE TABLE `dogs_details` (
`DOG_ID` int(11)
,`DNAME` varchar(10)
,`DAGE` int(11)
,`DSEX` varchar(1)
,`DDATE` date
,`CERT_NO` int(11)
,`OWNER_ID` int(11)
,`ONAME` varchar(14)
,`SURNAME` varchar(13)
,`DOG_SHOW_ID` int(11)
,`DSNAME` varchar(10)
,`DPRICE` decimal(7,2)
);

-- --------------------------------------------------------

--
-- Table structure for table `dog_show`
--

CREATE TABLE `dog_show` (
  `DOG_SHOW_ID` int(11) NOT NULL,
  `DSNAME` varchar(10) DEFAULT NULL,
  `DPRICE` decimal(7,2) DEFAULT NULL,
  `LOCATION` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `dog_show`
--

INSERT INTO `dog_show` (`DOG_SHOW_ID`, `DSNAME`, `DPRICE`, `LOCATION`) VALUES
(1, 'Show1', 100.00, NULL),
(2, 'Show2', 150.00, NULL),
(3, 'Show3', 200.00, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `hash`
--

CREATE TABLE `hash` (
  `HASH_ID` int(11) NOT NULL,
  `DOG_ID` int(11) DEFAULT NULL,
  `DOG_SHOW_ID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `hash`
--

INSERT INTO `hash` (`HASH_ID`, `DOG_ID`, `DOG_SHOW_ID`) VALUES
(1, 77852, 1),
(2, 77853, 2),
(3, 77854, 3);

-- --------------------------------------------------------

--
-- Table structure for table `owner`
--

CREATE TABLE `owner` (
  `OWNER_ID` int(11) NOT NULL,
  `ONAME` varchar(14) DEFAULT NULL,
  `SURNAME` varchar(13) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `owner`
--

INSERT INTO `owner` (`OWNER_ID`, `ONAME`, `SURNAME`) VALUES
(30, 'CHRIS', 'EWAY'),
(25, 'JAMES', 'MINTS'),
(20, 'MICHELLE', 'DALLS');

-- --------------------------------------------------------

--
-- Structure for view `dogs_details`
--
DROP TABLE IF EXISTS `dogs_details`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `dogs_details`  AS SELECT `d`.`DOG_ID` AS `DOG_ID`, `d`.`DNAME` AS `DNAME`, `d`.`DAGE` AS `DAGE`, `d`.`DSEX` AS `DSEX`, `d`.`DDATE` AS `DDATE`, `d`.`CERT_NO` AS `CERT_NO`, `o`.`OWNER_ID` AS `OWNER_ID`, `o`.`ONAME` AS `ONAME`, `o`.`SURNAME` AS `SURNAME`, `ds`.`DOG_SHOW_ID` AS `DOG_SHOW_ID`, `ds`.`DSNAME` AS `DSNAME`, `ds`.`DPRICE` AS `DPRICE` FROM (((`dogs` `d` join `owner` `o` on(`d`.`OWNER_ID` = `o`.`OWNER_ID`)) join `hash` `h` on(`d`.`DOG_ID` = `h`.`DOG_ID`)) join `dog_show` `ds` on(`h`.`DOG_SHOW_ID` = `ds`.`DOG_SHOW_ID`)) ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `dogs`
--
ALTER TABLE `dogs`
  ADD PRIMARY KEY (`DOG_ID`),
  ADD KEY `dog_fk` (`OWNER_ID`);

--
-- Indexes for table `dog_show`
--
ALTER TABLE `dog_show`
  ADD PRIMARY KEY (`DOG_SHOW_ID`),
  ADD UNIQUE KEY `UNIQUE_DSNAME` (`DSNAME`);

--
-- Indexes for table `hash`
--
ALTER TABLE `hash`
  ADD PRIMARY KEY (`HASH_ID`),
  ADD KEY `hash_fk_V1` (`DOG_ID`),
  ADD KEY `hash_fk_V2` (`DOG_SHOW_ID`);

--
-- Indexes for table `owner`
--
ALTER TABLE `owner`
  ADD PRIMARY KEY (`OWNER_ID`),
  ADD UNIQUE KEY `UNIQUE_OWNER_NAME` (`ONAME`,`SURNAME`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `dogs`
--
ALTER TABLE `dogs`
  ADD CONSTRAINT `dog_fk` FOREIGN KEY (`OWNER_ID`) REFERENCES `owner` (`OWNER_ID`);

--
-- Constraints for table `hash`
--
ALTER TABLE `hash`
  ADD CONSTRAINT `hash_fk_V1` FOREIGN KEY (`DOG_ID`) REFERENCES `dogs` (`DOG_ID`),
  ADD CONSTRAINT `hash_fk_V2` FOREIGN KEY (`DOG_SHOW_ID`) REFERENCES `dog_show` (`DOG_SHOW_ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
