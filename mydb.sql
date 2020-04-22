-- phpMyAdmin SQL Dump
-- version 5.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 22, 2020 at 07:17 PM
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
(1, 5, 'Shashank', 6, 1, '2020-05-04', '13:00', '2020-05-09', 5),
(2, 3, 'Helo', 3, 1, '2020-05-04', '13:00', '2020-05-06', 2),
(6, 7, 'Niharika Jaiswal', 5, 1, '2020-05-05', '10:00', '2020-05-07', 2),
(7, 3, 'Sp', 6, 1, '2020-04-21', '01:02', '2020-04-23', 1),
(8, 27, 'ved', 6, 1, '2020-04-30', '00:00', '2020-05-13', 13),
(9, 27, 'Sample', 4, 1, '2020-04-23', '01:02', '2020-05-02', 9),
(10, 6, 'Shashank', 3, 1, '2020-04-30', '12:12', '2020-05-07', 7);

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
(1, 'James', 'Gordon', '03/04/1995', 'james.jordon17@gmail.com', 1234567890, 'james_jordan', 'james', 'Male'),
(2, 'emily', 'Clark', '06/02/1992', 'clark12@gmail.com', 2147483647, 'usename', 'pawoo', 'Female'),
(3, 'Shrut', 'Desai', '23/12/1998', 'ss@gfh.v', 1234567890, 'shrut_d', 'hello', 'Female'),
(5, 'Shashank', 'Prasad', '05/08/1999', 'shashank.prasad11@gmail.com', 2147483647, 'sp_vit', 'admin', 'Male'),
(6, 'Shivangi ', 'Prasad', '29/09/1994', 'shivangiprsd@gmail.com', 2147483647, 'shivangi', 'shivangi', 'Female'),
(7, 'Niharika', 'Jaiswal', '03/04/1992', 'niharika_03@gmail.com', 2147483647, 'niki', 'niharika', 'Female'),
(8, 'Shashank', 'Prasad', '15/04/1987', 'shashank@gmail.com', 2147483647, 'sdad', '123', 'Female'),
(27, 'Harsh', 'Prasad', '20-10-1998', 'vedant20003@gmail.com', 2147483647, 'Vedant', '123456', 'Male');

-- --------------------------------------------------------

--
-- Table structure for table `payment`
--

CREATE TABLE `payment` (
  `Payment ID` int(11) NOT NULL,
  `BookingID` int(11) NOT NULL,
  `Card_Number` bigint(20) NOT NULL,
  `Card_Expiration_date` text NOT NULL,
  `CVV` int(11) NOT NULL,
  `Owner_name` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `payment`
--

INSERT INTO `payment` (`Payment ID`, `BookingID`, `Card_Number`, `Card_Expiration_date`, `CVV`, `Owner_name`) VALUES
(1, 7, 1234567894562134, '04/12', 256, 'Shashank Prasad'),
(2, 9, 1234564564789657, '04/22', 256, 'Vedant'),
(3, 10, 1234123412341234, '11/22', 234, 'Shivangi');

-- --------------------------------------------------------

--
-- Table structure for table `rooms`
--

CREATE TABLE `rooms` (
  `RoomID` int(11) NOT NULL,
  `RoomType` text NOT NULL,
  `GuestsCapacity` int(11) NOT NULL,
  `Fare` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `rooms`
--

INSERT INTO `rooms` (`RoomID`, `RoomType`, `GuestsCapacity`, `Fare`) VALUES
(1, 'Single Room', 1, 1500),
(2, 'Deluxe Room', 2, 2500),
(3, 'Super Deluxe Room', 3, 3500),
(4, 'Executive Suite', 6, 7000),
(5, 'Garden Suite', 8, 8000),
(6, 'President Suite', 8, 10000);

-- --------------------------------------------------------

--
-- Table structure for table `sampletable`
--

CREATE TABLE `sampletable` (
  `ID` int(150) NOT NULL,
  `Full Name` text NOT NULL,
  `Email` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `sampletable`
--

INSERT INTO `sampletable` (`ID`, `Full Name`, `Email`) VALUES
(1, 'James Bond', 'james.bond@yahoo.com'),
(2, 'Tony Start', 'tony_ironman@gmail.com');

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
-- Indexes for table `sampletable`
--
ALTER TABLE `sampletable`
  ADD PRIMARY KEY (`ID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `bookings`
--
ALTER TABLE `bookings`
  MODIFY `BookingID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `clients`
--
ALTER TABLE `clients`
  MODIFY `ClientID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `payment`
--
ALTER TABLE `payment`
  MODIFY `Payment ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `rooms`
--
ALTER TABLE `rooms`
  MODIFY `RoomID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `sampletable`
--
ALTER TABLE `sampletable`
  MODIFY `ID` int(150) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

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
