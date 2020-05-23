-- phpMyAdmin SQL Dump
-- version 5.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 08, 2020 at 02:57 AM
-- Server version: 10.4.11-MariaDB
-- PHP Version: 7.3.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `mydb`
--

-- --------------------------------------------------------

--
-- Table structure for table `bookings`
--

CREATE TABLE `bookings` (
  `BookingID` int(11) NOT NULL,
  `ClientID` int(11) NOT NULL,
  `Name` text NOT NULL,
  `RoomID` int(11) NOT NULL,
  `NumberOfRooms` int(11) NOT NULL,
  `CheckInDate` text NOT NULL,
  `CheckInTime` text NOT NULL,
  `CheckOutDate` text NOT NULL,
  `Days` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `bookings`
--

INSERT INTO `bookings` (`BookingID`, `ClientID`, `Name`, `RoomID`, `NumberOfRooms`, `CheckInDate`, `CheckInTime`, `CheckOutDate`, `Days`) VALUES
(23, 35, 'Shivangi', 4, 2, '2020-04-30', '14:22', '2020-05-02', 2),
(24, 33, 'Shivangi', 2, 1, '2020-04-27', '02:22', '2020-04-27', 1),
(25, 33, 'sdf', 2, 2, '2020-04-29', '02:01', '2020-04-30', 1),
(26, 36, 'harsh', 4, 5, '2020-04-29', '01:01', '2020-04-30', 1),
(27, 36, 'Ved', 6, 3, '2020-04-28', '02:01', '2020-05-09', 11),
(28, 37, 'Shashank', 6, 3, '2020-04-29', '13:03', '2020-04-30', 1),
(29, 38, 'mansi', 1, 2, '2020-05-04', '00:00', '2020-05-11', 7),
(30, 35, 'Sp', 5, 2, '2020-05-13', '13:02', '2020-05-22', 9),
(31, 35, 'sf', 2, 2, '2020-05-20', '01:02', '2020-05-22', 2),
(32, 35, 'Shashank', 3, 1, '2020-05-06', '14:01', '2020-05-07', 1);

-- --------------------------------------------------------

--
-- Table structure for table `clients`
--

CREATE TABLE `clients` (
  `ClientID` int(11) NOT NULL,
  `First_Name` text NOT NULL,
  `Last_Name` text NOT NULL,
  `DOB` text NOT NULL,
  `Email` text NOT NULL,
  `Contact_Number` int(11) NOT NULL,
  `username` text NOT NULL,
  `password` text NOT NULL,
  `Gender` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `clients`
--

INSERT INTO `clients` (`ClientID`, `First_Name`, `Last_Name`, `DOB`, `Email`, `Contact_Number`, `username`, `password`, `Gender`) VALUES
(33, 'Harshit', 'Prasad', '21/05/1994', 'harshit_p@gmail.com', 2147483647, 'harshit_p', '$2b$10$T8FEYtjcjIFynfZXhRTjPeRFtQRpORCp.Jag9J7OPKe7BHdGLdEbe', 'Male'),
(34, 'Emily', 'Rodes', '18/04/1996', 'er@gmail.com', 2147483647, 'emily_r', '$2b$10$hDWiZofDZL1qBnf2bMO56OikKEg/epeFCCkj0qBC18/WoBProCT4.', 'Male'),
(35, 'Shivangi', 'Prasad', '29/09/1995', 'shivangiprsd@gmail.com', 2147483647, 'shivangi', '$2b$10$2n9GqVBKNmXCIuMoUdinYOWuYPBZfzm7/0gead21L.d2B6JiQAqPK', 'Female'),
(36, 'Harsh', 'Prasad', '20/10/1998', 'vedant20003@gmail.com', 2147483647, 'Vedant', '$2b$10$CZT4lzTK3.NVm0WLQTOEh.jzjSj35taoda1bg/89kD/E8pkUnm6hK', 'Male'),
(37, 'Shrut', 'Desai', '23/12/1998', 'shrutd@gmail.com', 2147483647, 'shrut_d', '$2b$10$7pHOKVCOwHlNNTEG/aC9o.4XjfiGR1DcfOTr..ziMgyr.9uN56tdS', 'Female'),
(38, 'mansi', 'jaiswal', '05/04/2001', 'mansijaiswal0504@gmail.com', 2147483647, 'mansi jaiswal', '$2b$10$3xLn3mocWgd3XJpQMMrP1ubvHU.bkXHHGhJ4lLuICY/XrKew3TkK.', 'Female'),
(40, 'admin', 'admin', '14/05/1991', 'ad@gmail.com', 1234567890, 'admin123', '$2b$10$.0CsH7CwtfFbLdyEAj/O2.SerXAo2sxNmikZe8.lWrdgHzfFDRJ4i', 'Male'),
(41, 'aishwarya', 'Chandak', '10/05/1972', 'asih@gmail', 1234567898, 'aish', '$2b$10$wB.roZIvCvsbk4cAmpBL9ertrSz7eMIAWWLtUdIRviwTQjf1PxH06', 'Female'),
(42, 'Pradnya', 'Katariya', '08/05/1986', 'pradnya@gmail', 1234567892, 'pradz', '$2b$10$N80Kie9hCiEnn36veuduU.PNxSpNjQOxzbNhL0500ZJxrc05zztKW', 'Female'),
(43, 'Harsh', 'P', '04/05/1994', 'harsh@gmail.com', 1234567897, 'harsh', '$2b$10$YOEtSfL5XG3awc3ei/vZWe9A84j3j4g6EQrIWE5OJHuc6G0/BNx02', 'Male');

-- --------------------------------------------------------

--
-- Table structure for table `payment`
--

CREATE TABLE `payment` (
  `Payment ID` int(11) NOT NULL,
  `BookingID` int(11) NOT NULL,
  `Card_Number` text NOT NULL,
  `Card_Expiration_date` text NOT NULL,
  `CVV` int(11) NOT NULL,
  `Owner_name` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `payment`
--

INSERT INTO `payment` (`Payment ID`, `BookingID`, `Card_Number`, `Card_Expiration_date`, `CVV`, `Owner_name`) VALUES
(16, 23, '$2b$10$rHoEDNJjwGamfzHYtXuhZu7Jpg5KS.01m0tN8wT7ZeQg3NuVsRdh6', '11/24', 253, 'Shivangi'),
(17, 24, '$2b$10$N1qZV/zCJWcDoWilDgV4z.WgAx5ZCt7EiINaBmKve3nAiKmDUPY1C', '12/21', 345, 'Harsh'),
(18, 25, '$2b$10$f/y66PHtV7xsQchwrzBKY.Nxmgo3tqSktLt0oe5KCCnWtUw95HKNK', '08/22', 256, 'Shashank'),
(19, 26, '$2b$10$8WkIY/vgtPq60BKnypQXZ.yFkibA/Gfs1ieUX70zFMBnuwtX6TkPG', '12/21', 246, 'Harsh'),
(20, 27, '$2b$10$g3.H/NO0AiqMa8InGMrUCOvqiWEQTGAjmtjMk4CS.0VOy7OkeQ6xm', '02/24', 145, 'VED'),
(21, 28, '$2b$10$LfVArm.fHNWdhaWpdIOl/OEyXk5lNX0lYLJ8MInTr2BMetD8GG67W', '07/21', 256, 'Shashank'),
(22, 29, '$2b$10$qHO3fvyWU4TvqL/SKGbvxeYgNQ8WEsdItCjGv2Xi1dxhNLT68MRBm', '04/25', 481, 'Mansi'),
(23, 30, '$2b$10$l08W.xBxNprbTDQKO3jspusFN1DekDa2hTlp1MQuKWm3N1m9Zgpee', '12/23', 256, 'SP'),
(24, 31, '$2b$10$QRV9VvqbUIpKL0i1AfMCDeTiWqNTEyI3uRkj72e0ngBecgPnllKKO', '10/25', 564, 'hello'),
(25, 32, '$2b$10$sudMhD.rry3UDr41Z6T9muFX7p/rc9HnHwftkldc5AMosaiTta8qO', '02/25', 456, 'Shahank');

-- --------------------------------------------------------

--
-- Table structure for table `rooms`
--

CREATE TABLE `rooms` (
  `RoomID` int(11) NOT NULL,
  `RoomType` text NOT NULL,
  `GuestsCapacity` int(11) NOT NULL,
  `Fare` int(11) NOT NULL,
  `Rooms_available` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `rooms`
--

INSERT INTO `rooms` (`RoomID`, `RoomType`, `GuestsCapacity`, `Fare`, `Rooms_available`) VALUES
(1, 'Single Room', 1, 2000, 21),
(2, 'Deluxe Room', 2, 2500, 23),
(3, 'Super Deluxe Room', 3, 3500, 24),
(4, 'Executive Suite', 6, 7000, 30),
(5, 'Garden Suite', 8, 8000, 23),
(6, 'President Suite', 8, 10000, 25);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bookings`
--
ALTER TABLE `bookings`
  ADD PRIMARY KEY (`BookingID`),
  ADD KEY `ClientID` (`ClientID`),
  ADD KEY `RoomID` (`RoomID`);

--
-- Indexes for table `clients`
--
ALTER TABLE `clients`
  ADD PRIMARY KEY (`ClientID`);

--
-- Indexes for table `payment`
--
ALTER TABLE `payment`
  ADD PRIMARY KEY (`Payment ID`),
  ADD KEY `BookingID` (`BookingID`);

--
-- Indexes for table `rooms`
--
ALTER TABLE `rooms`
  ADD PRIMARY KEY (`RoomID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `bookings`
--
ALTER TABLE `bookings`
  MODIFY `BookingID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT for table `clients`
--
ALTER TABLE `clients`
  MODIFY `ClientID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;

--
-- AUTO_INCREMENT for table `payment`
--
ALTER TABLE `payment`
  MODIFY `Payment ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `rooms`
--
ALTER TABLE `rooms`
  MODIFY `RoomID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `bookings`
--
ALTER TABLE `bookings`
  ADD CONSTRAINT `bookings_ibfk_1` FOREIGN KEY (`ClientID`) REFERENCES `clients` (`ClientID`),
  ADD CONSTRAINT `bookings_ibfk_2` FOREIGN KEY (`RoomID`) REFERENCES `rooms` (`RoomID`);

--
-- Constraints for table `payment`
--
ALTER TABLE `payment`
  ADD CONSTRAINT `payment_ibfk_1` FOREIGN KEY (`BookingID`) REFERENCES `bookings` (`BookingID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
