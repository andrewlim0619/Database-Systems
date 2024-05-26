-- phpMyAdmin SQL Dump
-- version 4.2.4
-- http://www.phpmyadmin.net
--
-- Host: ovid.u.washington.edu:20345
-- Generation Time: May 23, 2019 at 04:58 PM
-- Server version: 5.5.18
-- PHP Version: 7.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `point_of_sale`
--
CREATE DATABASE IF NOT EXISTS `point_of_sale` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `point_of_sale`;

-- --------------------------------------------------------

--
-- Table structure for table `address`
--

DROP TABLE IF EXISTS `address`;
CREATE TABLE IF NOT EXISTS `address` (
  `AddressID` int(11) NOT NULL DEFAULT '0',
  `StreetAddress` varchar(50) DEFAULT NULL,
  `CityName` varchar(50) DEFAULT NULL,
  `StateCode` varchar(2) DEFAULT NULL,
  `PostalCode` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `address`
--

INSERT INTO `address` (`AddressID`, `StreetAddress`, `CityName`, `StateCode`, `PostalCode`) VALUES
(1, '2246 Honey Anchor Link', 'Mudtown', 'MO', '64707-2567'),
(2, '2054 Thunder Ledge', 'Mermaid Run', 'IL', '61093-2962'),
(3, '1206 Middle Bluff Row', 'Cornstalk', 'TX', '79508-3900'),
(4, '6017 Sleepy Oak Landing', 'Strong', 'OR', '97756-1402'),
(5, '8856 Easy Meadow', 'Scuttlehole', 'NV', '89154-5655'),
(6, '4036 Cotton Townline', 'Knievels Corner', 'WA', '99421-5437'),
(7, '6183 Burning Embers Corner', 'Paducah', 'GA', '39969-8536'),
(8, '4909 Dusty Wharf', 'Negro Crossing', 'KY', '42858-3737'),
(9, '7696 Grand Valley', 'Breakneck', 'WV', '26500-3490'),
(10, '1866 Amber Highway', 'Ben Hur', 'WI', '54858-3987'),
(11, '301 High Deer Turnabout', 'Cowbell Corners', 'NM', '87893-6892'),
(12, '4107 Lazy Front', 'Uncompahgre', 'KY', '40946-6940'),
(13, '3295 Little Lagoon End', 'Mumper', 'NC', '28894-7704'),
(14, '4692 Cozy Island', 'Town Talk', 'IL', '62713-0463'),
(15, '1335 Foggy Brook Walk', 'Bow Bog', 'AZ', '85220-6969'),
(16, '6868 Pleasant Forest', 'Ducktown', 'SC', '29472-0477'),
(17, '3617 Clear Canyon', 'Sunlight', 'VT', '05258-1032'),
(18, '3120 Noble Wagon Heath', 'Wild Horse', 'HI', '96793-9099'),
(19, '3770 Cinder Orchard', 'Altoona', 'TX', '79695-4884'),
(20, '9675 Harvest Bear Extension', 'Bleiblerville', 'LA', '70271-4156'),
(21, '7059 Colonial Promenade', 'Owls Town', 'TX', '76288-5712'),
(22, '1418 Sunny Willow Farms', 'Strangers Home', 'KS', '67943-3843'),
(23, '1334 Fallen Vista', 'Counselor', 'AK', '99867-0993'),
(24, '5971 Lost Leaf Harbour', 'Great Good Place', 'ID', '83732-2661'),
(25, '8857 Broad Forest Highlands', 'Big Warm', 'CA', '91670-9796'),
(26, '2764 Merry Edge', 'Marcelin', 'MI', '48066-5567'),
(27, '7854 Blue Cloud Trace', 'Sebewaing', 'DC', '20087-7656'),
(28, '2888 Heather Manor', 'Powwow River', 'AL', '35245-0976'),
(29, '8149 Hazy Terrace', 'Cheektowaga', 'MI', '48294-9447'),
(30, '5651 Dewy Nectar Villas', 'Disputanta', 'NC', '28987-7040'),
(31, '7192 Umber Line', 'Ubet', 'NM', '87307-0130'),
(33, '1442 Quiet Vale', 'Spook City', 'NJ', '07175-9361'),
(34, '5632 Indian Lake Crescent', 'Possum Bluff', 'MO', '65477-4520'),
(35, '5321 Quaking Via', 'Fidelity', 'AR', '72281-2770'),
(36, '7837 Velvet Mall ', 'Happytown', 'AR', '72855-8510'),
(37, '9019 Stony Rise Grounds', 'Chuckle', 'NM', '87165-7234'),
(38, '5622 Silent Common', 'Tocktoethla', 'KY', '41375-2308'),
(39, '5582 Green Cove', 'Pie Town', 'MA', '01599-6648'),
(40, '9383 Wishing Elk Gate', 'Weeki Wachee', 'NY', '13866-2621'),
(41, '9430 Old Crossing', 'Tooktocaugee', 'TN', '37647-5412'),
(42, '3597 Crystal Cider Ridge', 'Lords Hill', 'SD', '57697-1028'),
(43, '9016 Tawny Goose Field', 'Four States', 'NV', '89801-0908'),
(44, '8432 Silver Court', 'Beaver', 'IN', '47916-7239'),
(45, '4064 Iron Quail Glade', 'Weyauwega', 'UT', '84931-0058'),
(46, '6650 Misty Horse Swale', 'Quoddy', 'IN', '47589-3968'),
(47, '6603 Emerald Subdivision', 'Curfew', 'MT', '59440-0549'),
(48, '2066 Shady Spring Bank', 'Bissell', 'AZ', '85638-3309'),
(49, '5897 Hidden Mountain Heights', 'Hill Number 2', 'CT', '06613-2222'),
(50, '3256 Gentle View Quay', 'Coats', 'NY', '12079-3107'),
(51, '3064 Jagged Apple Park', '	Bee Bayo', 'DE', '19862-6633');

-- --------------------------------------------------------

--
-- Table structure for table `catalogitem`
--

DROP TABLE IF EXISTS `catalogitem`;
CREATE TABLE IF NOT EXISTS `catalogitem` (
  `ItemNumber` int(11) NOT NULL DEFAULT '0',
  `ItemDescription` varchar(50) NOT NULL,
  `UnitCost` double DEFAULT NULL,
  `UnitPrice` double DEFAULT NULL,
  `CategoryCode` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `catalogitem`
--

INSERT INTO `catalogitem` (`ItemNumber`, `ItemDescription`, `UnitCost`, `UnitPrice`, `CategoryCode`) VALUES
(4, 'Ressikan Flute', 1000, 46000, 'Music Instruments'),
(8, 'Harolina', 400, 1500, 'Music Instruments'),
(33, 'Baliset', 750, 2500, 'Music Instruments'),
(34, 'Holophoner', 1500, 4500, 'Music Instruments'),
(35, 'Cosmic Treadmill', 7500000, 9000000, 'Temporal Equipment'),
(36, 'TARDIS', 7000000, 7500000, 'Temporal Equipment'),
(38, 'Time Portal', 750000, 1000000, 'Temporal Equipment'),
(39, 'Astromech Droid', 800000, 1000000, 'Robots'),
(40, 'Protocol Droid', 200000, 500000, 'Robots'),
(41, 'Mechanoid', 200000, 250000, 'Robots'),
(42, 'Custodian Droid', 2250, 3000, 'Robots');

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
CREATE TABLE IF NOT EXISTS `category` (
  `CategoryCode` varchar(50) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`CategoryCode`) VALUES
('Music Instruments'),
('Robots'),
('Temporal Equipment');

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
CREATE TABLE IF NOT EXISTS `customer` (
  `CustomerNumber` int(11) NOT NULL DEFAULT '0',
  `CustomerName` varchar(50) NOT NULL,
  `DefaultAddressID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`CustomerNumber`, `CustomerName`, `DefaultAddressID`) VALUES
(1, 'New Name', 42),
(2, 'Widget Corp', 39),
(3, 'Henry', 49),
(4, 'Mr. Sparkle', 47),
(5, 'Globex Corporation', 18),
(6, 'Quantum Industries', 50),
(7, 'Wentworth Industries', 46),
(8, 'Alamo Travis', 25),
(9, 'kin', 25),
(10, 'Flowers By Irene', 30),
(11, 'Sirius Cybernetics Corporation', 21),
(12, 'Corellian Engineering Corporation', 43),
(13, 'Zevo Toys', 6),
(14, 'wala', 27),
(15, 'Initech', 3),
(16, 'Stay Puft Corporation', 40),
(17, 'John Bon Jovi', 49),
(18, 'John jon', 39),
(19, 'C.H. Lavatory and Sons', 7),
(20, 'Big Kahuna Burger', 25);

-- --------------------------------------------------------

--
-- Table structure for table `orderitem`
--

DROP TABLE IF EXISTS `orderitem`;
CREATE TABLE IF NOT EXISTS `orderitem` (
  `OrderNumber` int(11) NOT NULL DEFAULT '0',
  `ItemNumber` int(11) NOT NULL DEFAULT '0',
  `Quantity` smallint(6) DEFAULT NULL,
  `UnitPrice` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `orderitem`
--

INSERT INTO `orderitem` (`OrderNumber`, `ItemNumber`, `Quantity`, `UnitPrice`) VALUES
(3, 35, 1, 8500000),
(3, 38, 1, 1000000),
(4, 36, 2, 7500000),
(5, 8, 1, 1500),
(5, 40, 1, 500000),
(5, 42, 5, 2500),
(6, 34, 3, 4500),
(7, 42, 10, 2500),
(8, 39, 1, 1000000),
(8, 40, 1, 500000),
(9, 42, 15, 2500),
(10, 33, 1, 2500),
(11, 38, 1, 1000000),
(12, 39, 1, 1000000),
(12, 40, 1, 500000),
(12, 41, 1, 250000),
(13, 40, 5, 500000),
(14, 40, 1, 500000),
(15, 42, 10, 2500),
(16, 8, 1, 1500),
(17, 41, 1, 250000),
(17, 42, 5, 2500),
(18, 40, 4, 500000),
(20, 42, 25, 2500),
(21, 34, 2, 4500),
(22, 35, 2, 8500000);

-- --------------------------------------------------------

--
-- Table structure for table `ordermaster`
--

DROP TABLE IF EXISTS `ordermaster`;
CREATE TABLE IF NOT EXISTS `ordermaster` (
  `OrderNumber` int(11) NOT NULL DEFAULT '0',
  `CustomerNumber` int(11) NOT NULL,
  `OrderDate` datetime NOT NULL,
  `BillsAddressID` int(11) DEFAULT NULL,
  `ShipsAddressID` int(11) DEFAULT NULL,
  `OrderMessage` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `ordermaster`
--

INSERT INTO `ordermaster` (`OrderNumber`, `CustomerNumber`, `OrderDate`, `BillsAddressID`, `ShipsAddressID`, `OrderMessage`) VALUES
(3, 11, '2012-01-01 00:00:00', 21, 22, NULL),
(4, 12, '2012-02-01 00:00:00', 43, 43, NULL),
(5, 6, '2012-02-01 00:00:00', 50, 50, NULL),
(6, 7, '2012-02-01 00:00:00', 46, 46, NULL),
(7, 16, '2012-03-01 00:00:00', 40, 40, NULL),
(8, 1, '2012-03-15 00:00:00', 49, 46, NULL),
(9, 16, '2012-03-31 00:00:00', 40, 40, NULL),
(10, 17, '2012-04-15 00:00:00', 49, 49, NULL),
(11, 15, '2012-04-30 00:00:00', 3, 3, NULL),
(12, 1, '2012-05-16 00:00:00', 42, 42, NULL),
(13, 9, '2012-07-01 00:00:00', 25, 25, NULL),
(14, 18, '2012-07-01 00:00:00', 39, 39, NULL),
(15, 16, '2012-08-15 00:00:00', 40, 40, NULL),
(16, 8, '2012-08-31 00:00:00', 25, 33, NULL),
(17, 20, '2012-09-01 00:00:00', 25, 25, NULL),
(18, 18, '2012-09-02 00:00:00', 39, 39, NULL),
(19, 2, '2012-09-03 00:00:00', 39, 39, NULL),
(20, 19, '2012-10-04 00:00:00', 7, 19, NULL),
(21, 8, '2012-11-05 00:00:00', 25, 25, NULL),
(22, 11, '2012-12-31 00:00:00', 21, 21, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `state`
--

DROP TABLE IF EXISTS `state`;
CREATE TABLE IF NOT EXISTS `state` (
  `StateCode` varchar(2) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `state`
--

INSERT INTO `state` (`StateCode`) VALUES
('AK'),
('AL'),
('AR'),
('AS'),
('AZ'),
('CA'),
('CO'),
('CT'),
('DC'),
('DE'),
('FL'),
('GA'),
('GU'),
('HI'),
('IA'),
('ID'),
('IL'),
('IN'),
('KS'),
('KY'),
('LA'),
('MA'),
('MD'),
('ME'),
('MI'),
('MN'),
('MO'),
('MS'),
('MT'),
('NC'),
('ND'),
('NE'),
('NH'),
('NJ'),
('NM'),
('NV'),
('NY'),
('OH'),
('OK'),
('OR'),
('PA'),
('PR'),
('RI'),
('SC'),
('SD'),
('TN'),
('TX'),
('UT'),
('VA'),
('VI'),
('VT'),
('WA'),
('WI'),
('WV'),
('WY');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `address`
--
ALTER TABLE `address`
 ADD PRIMARY KEY (`AddressID`), ADD KEY `StateIdx` (`StateCode`);

--
-- Indexes for table `catalogitem`
--
ALTER TABLE `catalogitem`
 ADD PRIMARY KEY (`ItemNumber`), ADD KEY `CategoryIdx` (`CategoryCode`), ADD KEY `DescriptionIdx` (`ItemDescription`);

--
-- Indexes for table `category`
--
ALTER TABLE `category`
 ADD PRIMARY KEY (`CategoryCode`);

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
 ADD PRIMARY KEY (`CustomerNumber`), ADD UNIQUE KEY `CustomerName` (`CustomerName`), ADD KEY `AddressIdx` (`DefaultAddressID`);

--
-- Indexes for table `orderitem`
--
ALTER TABLE `orderitem`
 ADD PRIMARY KEY (`OrderNumber`,`ItemNumber`), ADD KEY `ItemNumber` (`ItemNumber`);

--
-- Indexes for table `ordermaster`
--
ALTER TABLE `ordermaster`
 ADD PRIMARY KEY (`OrderNumber`), ADD KEY `CustomerIdx` (`CustomerNumber`), ADD KEY `BillsIdx` (`BillsAddressID`), ADD KEY `ShipsIdx` (`ShipsAddressID`), ADD KEY `DateIdx` (`OrderDate`);

--
-- Indexes for table `state`
--
ALTER TABLE `state`
 ADD PRIMARY KEY (`StateCode`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `address`
--
ALTER TABLE `address`
ADD CONSTRAINT `address_ibfk_1` FOREIGN KEY (`StateCode`) REFERENCES `state` (`StateCode`);

--
-- Constraints for table `catalogitem`
--
ALTER TABLE `catalogitem`
ADD CONSTRAINT `catalogitem_ibfk_1` FOREIGN KEY (`CategoryCode`) REFERENCES `category` (`CategoryCode`);

--
-- Constraints for table `customer`
--
ALTER TABLE `customer`
ADD CONSTRAINT `customer_ibfk_1` FOREIGN KEY (`DefaultAddressID`) REFERENCES `address` (`AddressID`);

--
-- Constraints for table `orderitem`
--
ALTER TABLE `orderitem`
ADD CONSTRAINT `orderitem_ibfk_1` FOREIGN KEY (`OrderNumber`) REFERENCES `ordermaster` (`OrderNumber`),
ADD CONSTRAINT `orderitem_ibfk_2` FOREIGN KEY (`ItemNumber`) REFERENCES `catalogitem` (`ItemNumber`);

--
-- Constraints for table `ordermaster`
--
ALTER TABLE `ordermaster`
ADD CONSTRAINT `ordermaster_ibfk_1` FOREIGN KEY (`CustomerNumber`) REFERENCES `customer` (`CustomerNumber`),
ADD CONSTRAINT `ordermaster_ibfk_2` FOREIGN KEY (`BillsAddressID`) REFERENCES `address` (`AddressID`),
ADD CONSTRAINT `ordermaster_ibfk_3` FOREIGN KEY (`ShipsAddressID`) REFERENCES `address` (`AddressID`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
