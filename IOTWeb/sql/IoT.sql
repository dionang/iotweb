-- phpMyAdmin SQL Dump
-- version 4.8.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Apr 03, 2019 at 08:22 AM
-- Server version: 5.7.24
-- PHP Version: 7.2.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `iot`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
CREATE TABLE IF NOT EXISTS `admin` (
  `email` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `password` varchar(60) NOT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`email`, `name`, `password`) VALUES
('dion', 'dion', '$2a$10$4HNWCiIUWO3k1yQz6GiLi.R6QnR.VFHFLz73IpPTvBJRQoYyDweyy');

-- --------------------------------------------------------

--
-- Table structure for table `beacon`
--

DROP TABLE IF EXISTS `beacon`;
CREATE TABLE IF NOT EXISTS `beacon` (
  `bid` varchar(20) NOT NULL,
  `location` varchar(20) NOT NULL,
  PRIMARY KEY (`bid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `beacon`
--

INSERT INTO `beacon` (`bid`, `location`) VALUES
('iotg4smusg17', 'labs'),
('iotg4smusg31', 'project way');

-- --------------------------------------------------------

--
-- Table structure for table `event`
--

DROP TABLE IF EXISTS `event`;
CREATE TABLE IF NOT EXISTS `event` (
  `eid` int(20) NOT NULL AUTO_INCREMENT,
  `eventName` varchar(20) NOT NULL,
  PRIMARY KEY (`eid`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `event`
--

INSERT INTO `event` (`eid`, `eventName`) VALUES
(1, 'Event at project way'),
(2, 'Event at labs');

-- --------------------------------------------------------

--
-- Table structure for table `eventcategory`
--

DROP TABLE IF EXISTS `eventcategory`;
CREATE TABLE IF NOT EXISTS `eventcategory` (
  `eid` int(20) NOT NULL,
  `category` varchar(20) NOT NULL,
  PRIMARY KEY (`eid`,`category`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `eventcategory`
--

INSERT INTO `eventcategory` (`eid`, `category`) VALUES
(1, 'Media'),
(2, 'Music');

-- --------------------------------------------------------

--
-- Table structure for table `preferences`
--

DROP TABLE IF EXISTS `preferences`;
CREATE TABLE IF NOT EXISTS `preferences` (
  `email` varchar(30) NOT NULL,
  `category` varchar(20) NOT NULL,
  PRIMARY KEY (`email`,`category`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `reading`
--

DROP TABLE IF EXISTS `reading`;
CREATE TABLE IF NOT EXISTS `reading` (
  `location` varchar(30) NOT NULL,
  `datetime` datetime NOT NULL,
  `email` varchar(30) NOT NULL,
  PRIMARY KEY (`location`,`datetime`,`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `reading`
--

INSERT INTO `reading` (`location`, `datetime`, `email`) VALUES
('labs', '2019-03-18 12:00:16', 'moses'),
('labs', '2019-03-18 12:00:40', 'dion'),
('labs', '2019-03-18 12:05:16', 'moses'),
('labs', '2019-03-18 12:05:40', 'dion'),
('labs', '2019-03-18 12:10:16', 'moses'),
('labs', '2019-03-18 12:10:40', 'dion'),
('labs', '2019-03-18 12:15:16', 'moses'),
('labs', '2019-03-18 12:15:40', 'dion'),
('labs', '2019-03-18 12:20:16', 'moses'),
('labs', '2019-03-18 12:20:40', 'dion'),
('labs', '2019-03-18 12:25:16', 'moses'),
('labs', '2019-03-18 12:25:40', 'dion'),
('labs', '2019-03-18 14:36:58', 'dion'),
('labs', '2019-03-18 14:41:58', 'dion'),
('labs', '2019-03-18 14:46:58', 'dion'),
('labs', '2019-03-18 14:51:58', 'dion'),
('labs', '2019-03-18 14:56:58', 'dion'),
('labs', '2019-03-18 15:01:58', 'dion'),
('labs', '2019-03-18 15:06:58', 'dion'),
('labs', '2019-03-18 15:11:58', 'dion'),
('labs', '2019-03-18 15:16:58', 'dion'),
('labs', '2019-03-18 15:21:58', 'dion'),
('labs', '2019-03-18 15:26:58', 'dion'),
('labs', '2019-03-18 15:31:58', 'dion'),
('labs', '2019-03-18 15:36:58', 'dion'),
('labs', '2019-03-18 15:41:58', 'dion'),
('labs', '2019-03-18 15:46:58', 'dion'),
('labs', '2019-03-18 15:51:58', 'dion'),
('labs', '2019-03-18 15:56:58', 'dion'),
('labs', '2019-03-18 16:01:58', 'dion'),
('labs', '2019-03-18 16:06:58', 'dion'),
('labs', '2019-03-18 16:11:58', 'dion'),
('labs', '2019-03-18 16:16:58', 'dion'),
('labs', '2019-03-18 16:21:58', 'dion'),
('labs', '2019-03-18 16:26:58', 'dion'),
('labs', '2019-03-18 16:31:58', 'dion'),
('labs', '2019-03-18 16:36:58', 'dion'),
('labs', '2019-03-18 16:41:58', 'dion'),
('labs', '2019-03-18 16:46:58', 'dion'),
('labs', '2019-03-18 16:51:58', 'dion'),
('labs', '2019-03-18 16:56:58', 'dion'),
('labs', '2019-03-18 17:01:58', 'dion'),
('labs', '2019-03-18 17:06:58', 'dion'),
('labs', '2019-03-18 17:11:58', 'dion'),
('labs', '2019-03-18 17:16:58', 'dion'),
('labs', '2019-03-18 17:21:58', 'dion'),
('labs', '2019-03-18 17:26:58', 'dion'),
('labs', '2019-03-18 17:31:58', 'dion'),
('labs', '2019-03-18 17:36:58', 'dion'),
('labs', '2019-03-18 17:41:58', 'dion'),
('labs', '2019-03-18 17:46:58', 'dion'),
('labs', '2019-03-18 17:51:58', 'dion'),
('labs', '2019-03-18 17:56:58', 'dion'),
('labs', '2019-03-18 18:01:58', 'dion'),
('labs', '2019-03-18 18:06:58', 'dion'),
('labs', '2019-03-18 18:11:58', 'dion'),
('labs', '2019-03-18 18:16:58', 'dion'),
('labs', '2019-03-18 18:21:58', 'dion'),
('labs', '2019-03-18 18:26:58', 'dion'),
('labs', '2019-03-18 18:31:58', 'dion'),
('labs', '2019-03-18 18:36:58', 'dion'),
('labs', '2019-03-18 18:41:58', 'dion'),
('labs', '2019-03-19 10:20:31', 'dion'),
('labs', '2019-03-19 10:25:31', 'dion'),
('labs', '2019-03-19 10:30:31', 'dion'),
('labs', '2019-03-19 10:35:31', 'dion'),
('labs', '2019-03-19 10:40:31', 'dion'),
('labs', '2019-03-19 10:45:31', 'dion'),
('labs', '2019-03-19 10:50:31', 'dion'),
('labs', '2019-03-19 10:55:31', 'dion'),
('labs', '2019-03-19 11:00:31', 'dion'),
('labs', '2019-03-19 11:05:31', 'dion'),
('labs', '2019-03-19 11:10:31', 'dion'),
('labs', '2019-03-19 11:15:31', 'dion'),
('labs', '2019-03-19 11:20:31', 'dion'),
('labs', '2019-03-19 11:25:31', 'dion'),
('labs', '2019-03-19 11:30:31', 'dion'),
('labs', '2019-03-19 11:35:31', 'dion'),
('labs', '2019-03-19 11:40:31', 'dion'),
('labs', '2019-03-19 11:45:31', 'dion'),
('labs', '2019-03-19 11:50:31', 'dion'),
('labs', '2019-03-19 11:55:31', 'dion'),
('labs', '2019-03-19 12:00:31', 'dion'),
('labs', '2019-03-19 12:05:31', 'dion'),
('labs', '2019-03-19 12:10:31', 'dion'),
('labs', '2019-03-19 12:15:31', 'dion'),
('labs', '2019-03-21 09:03:52', 'moses'),
('labs', '2019-03-21 09:08:52', 'moses'),
('labs', '2019-03-21 09:13:52', 'moses'),
('labs', '2019-03-21 09:18:52', 'moses'),
('labs', '2019-03-21 09:23:52', 'moses'),
('labs', '2019-03-21 09:28:52', 'moses'),
('labs', '2019-03-21 09:33:52', 'moses'),
('labs', '2019-03-21 09:38:52', 'moses'),
('labs', '2019-03-21 09:43:52', 'moses'),
('labs', '2019-03-21 09:48:52', 'moses'),
('labs', '2019-03-21 09:53:52', 'moses'),
('labs', '2019-03-21 09:58:52', 'moses'),
('labs', '2019-03-21 10:03:52', 'moses'),
('labs', '2019-03-21 10:08:52', 'moses'),
('labs', '2019-03-21 10:13:52', 'moses'),
('labs', '2019-03-21 10:18:52', 'moses'),
('labs', '2019-03-21 10:23:52', 'moses'),
('labs', '2019-03-21 10:28:52', 'moses'),
('labs', '2019-03-21 10:33:52', 'moses'),
('labs', '2019-03-21 10:38:52', 'moses'),
('labs', '2019-03-21 10:43:52', 'moses'),
('labs', '2019-03-21 10:48:52', 'moses'),
('labs', '2019-03-21 10:53:52', 'moses'),
('labs', '2019-03-21 10:58:52', 'moses'),
('labs', '2019-03-21 11:03:52', 'moses'),
('labs', '2019-03-21 11:08:52', 'moses'),
('labs', '2019-03-21 11:13:52', 'moses'),
('labs', '2019-03-21 11:18:52', 'moses'),
('labs', '2019-03-21 11:23:52', 'moses'),
('labs', '2019-03-21 11:28:52', 'moses'),
('labs', '2019-03-21 11:33:52', 'moses'),
('labs', '2019-03-21 11:38:52', 'moses'),
('labs', '2019-03-21 11:43:52', 'moses'),
('labs', '2019-03-21 11:48:52', 'moses'),
('labs', '2019-03-22 15:10:04', 'jacky'),
('labs', '2019-03-22 15:15:04', 'jacky'),
('labs', '2019-03-22 15:20:04', 'jacky'),
('labs', '2019-03-22 15:25:04', 'jacky'),
('labs', '2019-03-22 15:30:04', 'jacky'),
('labs', '2019-03-22 15:35:04', 'jacky'),
('labs', '2019-03-22 15:40:04', 'jacky'),
('labs', '2019-03-22 15:45:04', 'jacky'),
('labs', '2019-03-22 15:50:04', 'jacky'),
('labs', '2019-03-22 15:55:04', 'jacky'),
('labs', '2019-03-22 16:00:04', 'jacky'),
('labs', '2019-03-22 16:05:04', 'jacky'),
('labs', '2019-03-22 16:10:04', 'jacky'),
('labs', '2019-03-22 16:15:04', 'jacky'),
('labs', '2019-03-22 16:20:04', 'jacky'),
('labs', '2019-03-22 16:25:04', 'jacky'),
('labs', '2019-03-22 16:30:04', 'jacky'),
('labs', '2019-03-22 16:35:04', 'jacky'),
('labs', '2019-03-22 16:40:04', 'jacky'),
('labs', '2019-03-22 16:45:04', 'jacky'),
('labs', '2019-03-22 16:50:04', 'jacky'),
('labs', '2019-03-22 16:55:04', 'jacky'),
('labs', '2019-03-22 17:00:04', 'jacky'),
('labs', '2019-03-22 17:05:04', 'jacky'),
('labs', '2019-03-22 17:10:04', 'jacky'),
('labs', '2019-03-22 17:15:04', 'jacky'),
('labs', '2019-03-22 17:20:04', 'jacky'),
('labs', '2019-03-22 17:25:04', 'jacky'),
('labs', '2019-03-22 17:30:04', 'jacky'),
('labs', '2019-03-22 17:35:04', 'jacky'),
('labs', '2019-03-22 17:40:04', 'jacky'),
('labs', '2019-03-22 17:45:04', 'jacky'),
('labs', '2019-03-22 17:50:04', 'jacky'),
('labs', '2019-03-22 17:55:04', 'jacky'),
('labs', '2019-03-22 18:00:04', 'jacky'),
('labs', '2019-03-22 18:05:04', 'jacky'),
('labs', '2019-03-22 18:10:04', 'jacky'),
('labs', '2019-03-22 18:15:04', 'jacky'),
('labs', '2019-03-22 18:20:04', 'jacky'),
('labs', '2019-03-22 18:25:04', 'jacky'),
('labs', '2019-03-22 18:30:04', 'jacky'),
('labs', '2019-03-22 18:35:04', 'jacky'),
('labs', '2019-03-22 18:40:04', 'jacky'),
('labs', '2019-03-22 18:45:04', 'jacky'),
('labs', '2019-03-22 18:50:04', 'jacky'),
('labs', '2019-03-22 18:55:04', 'jacky'),
('labs', '2019-03-22 19:00:04', 'jacky'),
('labs', '2019-03-22 19:05:04', 'jacky'),
('labs', '2019-03-22 19:10:04', 'jacky'),
('labs', '2019-03-22 19:15:04', 'jacky'),
('labs', '2019-03-22 19:20:04', 'jacky'),
('labs', '2019-03-22 19:25:04', 'jacky'),
('labs', '2019-03-22 19:30:04', 'jacky'),
('labs', '2019-03-22 19:35:04', 'jacky'),
('labs', '2019-03-22 19:40:04', 'jacky'),
('labs', '2019-03-22 19:45:04', 'jacky'),
('labs', '2019-03-22 19:50:04', 'jacky'),
('labs', '2019-03-22 19:55:04', 'jacky'),
('labs', '2019-03-24 12:15:19', 'jacky'),
('labs', '2019-03-24 12:20:19', 'jacky'),
('labs', '2019-03-24 12:25:19', 'jacky'),
('labs', '2019-03-24 12:30:19', 'jacky'),
('labs', '2019-03-24 12:35:19', 'jacky'),
('labs', '2019-03-24 12:40:19', 'jacky'),
('labs', '2019-03-24 12:45:19', 'jacky'),
('labs', '2019-03-24 12:50:19', 'jacky'),
('labs', '2019-03-24 12:55:19', 'jacky'),
('labs', '2019-03-24 13:00:19', 'jacky'),
('labs', '2019-03-24 13:05:19', 'jacky'),
('labs', '2019-03-24 13:10:19', 'jacky'),
('labs', '2019-03-24 13:15:19', 'jacky'),
('labs', '2019-03-24 13:20:19', 'jacky'),
('labs', '2019-03-24 13:25:19', 'jacky'),
('labs', '2019-03-24 13:30:19', 'jacky'),
('labs', '2019-03-24 13:35:19', 'jacky'),
('labs', '2019-03-24 13:40:19', 'jacky'),
('labs', '2019-03-24 13:45:19', 'jacky'),
('labs', '2019-03-24 13:50:19', 'jacky'),
('labs', '2019-03-24 13:55:19', 'jacky'),
('labs', '2019-03-24 14:00:19', 'jacky'),
('labs', '2019-03-24 14:05:19', 'jacky'),
('labs', '2019-03-24 14:10:19', 'jacky'),
('labs', '2019-03-24 14:15:19', 'jacky'),
('labs', '2019-03-24 14:20:19', 'jacky'),
('labs', '2019-03-24 14:25:19', 'jacky'),
('labs', '2019-03-26 16:23:04', 'jacky'),
('labs', '2019-03-26 16:28:04', 'jacky'),
('labs', '2019-03-26 16:33:04', 'jacky'),
('labs', '2019-03-26 16:38:04', 'jacky'),
('labs', '2019-03-26 16:43:04', 'jacky'),
('labs', '2019-03-26 16:48:04', 'jacky'),
('labs', '2019-03-26 16:53:04', 'jacky'),
('labs', '2019-03-26 16:58:04', 'jacky'),
('labs', '2019-03-26 17:03:04', 'jacky'),
('labs', '2019-03-26 17:08:04', 'jacky'),
('labs', '2019-03-26 17:13:04', 'jacky'),
('labs', '2019-03-26 17:18:04', 'jacky'),
('labs', '2019-03-26 17:23:04', 'jacky'),
('labs', '2019-03-26 17:28:04', 'jacky'),
('labs', '2019-03-26 17:33:04', 'jacky'),
('labs', '2019-03-26 17:38:04', 'jacky'),
('labs', '2019-03-26 17:43:04', 'jacky'),
('labs', '2019-03-26 17:48:04', 'jacky'),
('labs', '2019-03-26 17:53:04', 'jacky'),
('labs', '2019-03-26 17:58:04', 'jacky'),
('labs', '2019-03-26 18:03:04', 'jacky'),
('labs', '2019-03-26 18:08:04', 'jacky'),
('labs', '2019-03-26 18:13:04', 'jacky'),
('labs', '2019-03-26 18:18:04', 'jacky'),
('labs', '2019-03-26 18:23:04', 'jacky'),
('labs', '2019-03-26 18:28:04', 'jacky'),
('labs', '2019-03-26 18:33:04', 'jacky'),
('labs', '2019-03-26 18:38:04', 'jacky'),
('labs', '2019-03-26 18:43:04', 'jacky'),
('labs', '2019-03-26 18:48:04', 'jacky'),
('labs', '2019-03-27 15:30:23', 'jacky'),
('labs', '2019-03-27 15:35:23', 'jacky'),
('labs', '2019-03-27 15:40:23', 'jacky'),
('labs', '2019-03-27 15:45:23', 'jacky'),
('labs', '2019-03-27 15:50:23', 'jacky'),
('labs', '2019-03-27 15:55:23', 'jacky'),
('labs', '2019-03-27 16:00:23', 'jacky'),
('labs', '2019-03-27 16:05:23', 'jacky'),
('labs', '2019-03-27 16:10:23', 'jacky'),
('labs', '2019-03-27 16:15:23', 'jacky'),
('labs', '2019-03-27 16:20:23', 'jacky'),
('labs', '2019-03-27 16:25:23', 'jacky'),
('labs', '2019-03-27 16:30:23', 'jacky'),
('labs', '2019-03-27 16:35:23', 'jacky'),
('labs', '2019-03-27 16:40:23', 'jacky'),
('labs', '2019-03-27 16:45:23', 'jacky'),
('labs', '2019-03-27 16:50:23', 'jacky'),
('labs', '2019-03-27 16:55:23', 'jacky'),
('labs', '2019-03-27 17:00:23', 'jacky'),
('labs', '2019-03-27 17:05:23', 'jacky'),
('labs', '2019-03-27 17:10:23', 'jacky'),
('labs', '2019-03-27 17:15:23', 'jacky'),
('labs', '2019-03-27 17:20:23', 'jacky'),
('labs', '2019-03-27 17:25:23', 'jacky'),
('labs', '2019-03-27 17:30:23', 'jacky'),
('labs', '2019-03-27 17:35:23', 'jacky'),
('labs', '2019-03-27 17:40:23', 'jacky'),
('labs', '2019-03-27 17:45:23', 'jacky'),
('labs', '2019-03-27 17:50:23', 'jacky'),
('labs', '2019-03-27 17:55:23', 'jacky'),
('labs', '2019-03-27 18:00:23', 'jacky'),
('labs', '2019-03-27 18:05:23', 'jacky'),
('labs', '2019-03-27 18:10:23', 'jacky'),
('labs', '2019-03-27 18:15:23', 'jacky'),
('labs', '2019-03-27 18:20:23', 'jacky'),
('labs', '2019-03-27 18:25:23', 'jacky'),
('labs', '2019-03-27 18:30:23', 'jacky'),
('labs', '2019-03-27 18:35:23', 'jacky'),
('labs', '2019-03-27 18:40:23', 'jacky'),
('labs', '2019-03-27 18:45:23', 'jacky'),
('labs', '2019-03-27 18:50:23', 'jacky'),
('labs', '2019-03-27 18:55:23', 'jacky'),
('labs', '2019-03-27 19:00:23', 'jacky'),
('labs', '2019-03-27 19:05:23', 'jacky'),
('labs', '2019-03-27 19:10:23', 'jacky'),
('labs', '2019-03-27 19:15:23', 'jacky'),
('labs', '2019-03-27 19:20:23', 'jacky'),
('labs', '2019-03-27 19:25:23', 'jacky'),
('labs', '2019-03-27 19:30:23', 'jacky'),
('labs', '2019-03-27 19:35:23', 'jacky'),
('labs', '2019-03-27 19:40:23', 'jacky'),
('labs', '2019-03-27 19:45:23', 'jacky'),
('labs', '2019-03-27 19:50:23', 'jacky'),
('labs', '2019-03-27 19:55:23', 'jacky'),
('labs', '2019-03-27 20:00:23', 'jacky'),
('labs', '2019-03-27 20:05:23', 'jacky'),
('labs', '2019-03-27 20:10:23', 'jacky'),
('labs', '2019-03-27 20:15:23', 'jacky'),
('project way', '2019-03-22 11:30:23', 'moses'),
('project way', '2019-03-22 11:32:12', 'dion'),
('project way', '2019-03-22 11:35:23', 'moses'),
('project way', '2019-03-22 11:37:12', 'dion'),
('project way', '2019-03-22 11:40:23', 'moses'),
('project way', '2019-03-22 11:42:12', 'dion'),
('project way', '2019-03-22 11:45:23', 'moses'),
('project way', '2019-03-22 11:47:12', 'dion'),
('project way', '2019-03-22 11:50:23', 'moses'),
('project way', '2019-03-22 11:52:12', 'dion'),
('project way', '2019-03-22 11:55:23', 'moses'),
('project way', '2019-03-22 11:57:12', 'dion'),
('project way', '2019-03-22 12:00:23', 'moses'),
('project way', '2019-03-22 12:02:12', 'dion'),
('project way', '2019-03-22 12:05:23', 'moses'),
('project way', '2019-03-22 12:07:12', 'dion'),
('project way', '2019-03-22 12:10:23', 'moses'),
('project way', '2019-03-22 12:12:12', 'dion'),
('project way', '2019-03-22 12:15:23', 'moses'),
('project way', '2019-03-22 12:17:12', 'dion'),
('project way', '2019-03-22 13:55:21', 'moses'),
('project way', '2019-03-22 14:00:21', 'moses'),
('project way', '2019-03-22 14:05:21', 'moses'),
('project way', '2019-03-22 14:10:21', 'moses'),
('project way', '2019-03-22 14:15:21', 'moses'),
('project way', '2019-03-22 14:20:21', 'moses'),
('project way', '2019-03-22 14:25:21', 'moses'),
('project way', '2019-03-22 14:30:21', 'moses'),
('project way', '2019-03-22 14:35:21', 'moses'),
('project way', '2019-03-22 14:40:21', 'moses'),
('project way', '2019-03-22 14:45:21', 'moses'),
('project way', '2019-03-22 14:50:21', 'moses'),
('project way', '2019-03-22 14:55:21', 'moses'),
('project way', '2019-03-22 15:00:21', 'moses'),
('project way', '2019-03-22 15:05:21', 'moses'),
('project way', '2019-03-22 15:10:21', 'moses'),
('project way', '2019-03-22 15:15:21', 'moses'),
('project way', '2019-03-22 15:20:21', 'moses'),
('project way', '2019-03-22 15:25:21', 'moses'),
('project way', '2019-03-22 15:30:21', 'moses'),
('project way', '2019-03-22 15:35:21', 'moses'),
('project way', '2019-03-22 15:40:21', 'moses'),
('project way', '2019-03-22 15:45:21', 'moses'),
('project way', '2019-03-22 15:50:21', 'moses'),
('project way', '2019-03-22 15:55:21', 'moses'),
('project way', '2019-03-22 16:00:21', 'moses'),
('project way', '2019-03-22 16:05:21', 'moses'),
('project way', '2019-03-22 16:10:21', 'moses'),
('project way', '2019-03-22 16:15:21', 'moses'),
('project way', '2019-03-22 16:20:21', 'moses'),
('project way', '2019-03-22 16:25:21', 'moses'),
('project way', '2019-03-22 16:30:21', 'moses'),
('project way', '2019-03-22 16:35:21', 'moses'),
('project way', '2019-03-22 16:40:21', 'moses'),
('project way', '2019-03-22 16:45:21', 'moses'),
('project way', '2019-03-22 16:50:21', 'moses'),
('project way', '2019-03-22 16:55:21', 'moses'),
('project way', '2019-03-22 17:00:21', 'moses'),
('project way', '2019-03-22 17:05:21', 'moses'),
('project way', '2019-03-22 17:10:21', 'moses'),
('project way', '2019-03-22 17:15:21', 'moses'),
('project way', '2019-03-22 17:20:21', 'moses'),
('project way', '2019-03-22 17:25:21', 'moses'),
('project way', '2019-03-22 17:30:21', 'moses'),
('project way', '2019-03-22 17:35:21', 'moses'),
('project way', '2019-03-22 17:40:21', 'moses'),
('project way', '2019-03-22 17:45:21', 'moses'),
('project way', '2019-03-22 17:50:21', 'moses'),
('project way', '2019-03-22 17:55:21', 'moses'),
('project way', '2019-03-22 18:00:21', 'moses'),
('project way', '2019-03-22 18:05:21', 'moses'),
('project way', '2019-03-22 18:10:21', 'moses'),
('project way', '2019-03-22 18:15:21', 'moses'),
('project way', '2019-03-22 18:20:21', 'moses'),
('project way', '2019-03-22 18:25:21', 'moses'),
('project way', '2019-03-25 11:32:27', 'dion'),
('project way', '2019-03-25 11:35:57', 'moses'),
('project way', '2019-03-25 11:37:27', 'dion'),
('project way', '2019-03-25 11:40:57', 'moses'),
('project way', '2019-03-25 11:42:27', 'dion'),
('project way', '2019-03-25 11:45:57', 'moses'),
('project way', '2019-03-25 11:47:27', 'dion'),
('project way', '2019-03-25 11:50:57', 'moses'),
('project way', '2019-03-25 11:52:27', 'dion'),
('project way', '2019-03-25 11:55:57', 'moses'),
('project way', '2019-03-25 11:57:27', 'dion'),
('project way', '2019-03-25 12:00:57', 'moses'),
('project way', '2019-03-25 12:02:27', 'dion'),
('project way', '2019-03-25 12:05:57', 'moses'),
('project way', '2019-03-25 12:07:27', 'dion'),
('project way', '2019-03-25 12:10:57', 'moses'),
('project way', '2019-03-25 12:12:27', 'dion'),
('project way', '2019-03-25 12:15:57', 'moses'),
('project way', '2019-03-25 12:17:27', 'dion'),
('project way', '2019-03-26 12:58:02', 'dion'),
('project way', '2019-03-26 13:03:02', 'dion'),
('project way', '2019-03-26 13:08:02', 'dion'),
('project way', '2019-03-26 13:13:02', 'dion'),
('project way', '2019-03-26 13:18:02', 'dion'),
('project way', '2019-03-26 13:23:02', 'dion'),
('project way', '2019-03-26 13:28:02', 'dion'),
('project way', '2019-03-26 13:33:02', 'dion'),
('project way', '2019-03-26 13:38:02', 'dion'),
('project way', '2019-03-26 13:43:02', 'dion'),
('project way', '2019-03-26 13:48:02', 'dion'),
('project way', '2019-03-26 13:53:02', 'dion'),
('project way', '2019-03-26 13:58:02', 'dion'),
('project way', '2019-03-26 14:03:02', 'dion'),
('project way', '2019-03-26 14:08:02', 'dion'),
('project way', '2019-03-26 14:13:02', 'dion'),
('project way', '2019-03-26 14:18:02', 'dion'),
('project way', '2019-03-26 14:23:02', 'dion'),
('project way', '2019-03-26 14:28:02', 'dion'),
('project way', '2019-03-26 14:33:02', 'dion'),
('project way', '2019-03-26 14:38:02', 'dion'),
('project way', '2019-03-26 14:43:02', 'dion'),
('project way', '2019-03-26 14:48:02', 'dion'),
('project way', '2019-03-26 14:53:02', 'dion'),
('project way', '2019-03-26 14:58:02', 'dion'),
('project way', '2019-03-26 15:03:02', 'dion'),
('project way', '2019-03-26 15:08:02', 'dion'),
('project way', '2019-03-26 15:13:02', 'dion'),
('project way', '2019-03-26 15:18:02', 'dion'),
('project way', '2019-03-26 15:23:02', 'dion'),
('project way', '2019-03-26 15:28:02', 'dion'),
('project way', '2019-03-27 15:02:43', 'dion'),
('project way', '2019-03-27 15:07:43', 'dion'),
('project way', '2019-03-27 15:12:43', 'dion'),
('project way', '2019-03-27 15:17:43', 'dion'),
('project way', '2019-03-27 15:22:43', 'dion'),
('project way', '2019-03-27 15:27:43', 'dion'),
('project way', '2019-03-27 15:32:43', 'dion'),
('project way', '2019-03-27 15:37:43', 'dion'),
('project way', '2019-03-27 15:42:43', 'dion'),
('project way', '2019-03-27 15:47:43', 'dion'),
('project way', '2019-03-27 15:52:43', 'dion'),
('project way', '2019-03-27 15:57:43', 'dion'),
('project way', '2019-03-27 16:02:43', 'dion'),
('project way', '2019-03-27 16:07:43', 'dion'),
('project way', '2019-03-27 16:12:43', 'dion'),
('project way', '2019-03-27 16:17:43', 'dion'),
('project way', '2019-03-27 16:22:43', 'dion'),
('project way', '2019-03-27 16:27:43', 'dion'),
('project way', '2019-03-27 16:32:43', 'dion'),
('project way', '2019-03-27 16:37:43', 'dion'),
('project way', '2019-03-27 16:42:43', 'dion'),
('project way', '2019-03-27 16:47:43', 'dion'),
('project way', '2019-03-27 16:52:43', 'dion'),
('project way', '2019-03-27 16:57:43', 'dion'),
('project way', '2019-03-27 17:02:43', 'dion'),
('project way', '2019-03-27 17:07:43', 'dion'),
('project way', '2019-03-27 17:12:43', 'dion'),
('project way', '2019-03-27 17:17:43', 'dion'),
('project way', '2019-03-27 17:22:43', 'dion'),
('project way', '2019-03-27 17:27:43', 'dion'),
('project way', '2019-03-27 17:32:43', 'dion'),
('project way', '2019-03-27 17:37:43', 'dion'),
('project way', '2019-03-27 17:42:43', 'dion'),
('project way', '2019-03-27 17:47:43', 'dion'),
('project way', '2019-03-27 17:52:43', 'dion'),
('project way', '2019-03-27 17:57:43', 'dion'),
('project way', '2019-03-27 18:02:43', 'dion'),
('project way', '2019-03-27 18:07:43', 'dion'),
('project way', '2019-03-27 18:12:43', 'dion'),
('project way', '2019-03-27 18:17:43', 'dion'),
('project way', '2019-03-27 18:22:43', 'dion'),
('project way', '2019-03-27 18:27:43', 'dion'),
('project way', '2019-03-27 18:32:43', 'dion'),
('project way', '2019-03-27 18:37:43', 'dion'),
('project way', '2019-03-27 18:42:43', 'dion'),
('project way', '2019-03-27 18:47:43', 'dion'),
('project way', '2019-03-27 18:52:43', 'dion'),
('project way', '2019-03-27 18:57:43', 'dion'),
('project way', '2019-03-27 19:02:43', 'dion'),
('project way', '2019-03-27 19:07:43', 'dion'),
('project way', '2019-03-27 19:12:43', 'dion'),
('project way', '2019-03-27 19:17:43', 'dion'),
('project way', '2019-03-27 19:22:43', 'dion'),
('project way', '2019-03-27 19:27:43', 'dion'),
('project way', '2019-03-28 14:15:37', 'moses'),
('project way', '2019-03-28 14:20:37', 'moses'),
('project way', '2019-03-28 14:25:37', 'moses'),
('project way', '2019-03-28 14:30:23', 'jacky'),
('project way', '2019-03-28 14:30:37', 'moses'),
('project way', '2019-03-28 14:35:23', 'jacky'),
('project way', '2019-03-28 14:35:37', 'moses'),
('project way', '2019-03-28 14:40:23', 'jacky'),
('project way', '2019-03-28 14:40:37', 'moses'),
('project way', '2019-03-28 14:45:23', 'jacky'),
('project way', '2019-03-28 14:45:37', 'moses'),
('project way', '2019-03-28 14:50:23', 'jacky'),
('project way', '2019-03-28 14:50:37', 'moses'),
('project way', '2019-03-28 14:55:23', 'jacky'),
('project way', '2019-03-28 14:55:37', 'moses'),
('project way', '2019-03-28 15:00:23', 'jacky'),
('project way', '2019-03-28 15:00:37', 'moses'),
('project way', '2019-03-28 15:05:23', 'jacky'),
('project way', '2019-03-28 15:05:37', 'moses'),
('project way', '2019-03-28 15:10:23', 'jacky'),
('project way', '2019-03-28 15:10:37', 'moses'),
('project way', '2019-03-28 15:15:23', 'jacky'),
('project way', '2019-03-28 15:15:37', 'moses'),
('project way', '2019-03-28 15:20:23', 'jacky'),
('project way', '2019-03-28 15:20:37', 'moses'),
('project way', '2019-03-28 15:25:23', 'jacky'),
('project way', '2019-03-28 15:25:37', 'moses'),
('project way', '2019-03-28 15:30:23', 'jacky'),
('project way', '2019-03-28 15:30:37', 'moses'),
('project way', '2019-03-28 15:35:23', 'jacky'),
('project way', '2019-03-28 15:35:37', 'moses'),
('project way', '2019-03-28 15:40:23', 'jacky'),
('project way', '2019-03-28 15:40:37', 'moses'),
('project way', '2019-03-28 15:45:23', 'jacky'),
('project way', '2019-03-28 15:45:37', 'moses'),
('project way', '2019-03-28 15:47:12', 'dion'),
('project way', '2019-03-28 15:50:23', 'jacky'),
('project way', '2019-03-28 15:50:37', 'moses'),
('project way', '2019-03-28 15:52:12', 'dion'),
('project way', '2019-03-28 15:55:23', 'jacky'),
('project way', '2019-03-28 15:55:37', 'moses'),
('project way', '2019-03-28 15:57:12', 'dion'),
('project way', '2019-03-28 16:00:23', 'jacky'),
('project way', '2019-03-28 16:00:37', 'moses'),
('project way', '2019-03-28 16:02:12', 'dion'),
('project way', '2019-03-28 16:05:23', 'jacky'),
('project way', '2019-03-28 16:05:37', 'moses'),
('project way', '2019-03-28 16:07:12', 'dion'),
('project way', '2019-03-28 16:10:23', 'jacky'),
('project way', '2019-03-28 16:10:37', 'moses'),
('project way', '2019-03-28 16:12:12', 'dion'),
('project way', '2019-03-28 16:15:23', 'jacky'),
('project way', '2019-03-28 16:15:37', 'moses'),
('project way', '2019-03-28 16:17:12', 'dion'),
('project way', '2019-03-28 16:20:23', 'jacky'),
('project way', '2019-03-28 16:20:37', 'moses'),
('project way', '2019-03-28 16:22:12', 'dion'),
('project way', '2019-03-28 16:25:23', 'jacky'),
('project way', '2019-03-28 16:25:37', 'moses'),
('project way', '2019-03-28 16:27:12', 'dion'),
('project way', '2019-03-28 16:30:23', 'jacky'),
('project way', '2019-03-28 16:30:37', 'moses'),
('project way', '2019-03-28 16:32:12', 'dion'),
('project way', '2019-03-28 16:35:23', 'jacky'),
('project way', '2019-03-28 16:35:37', 'moses'),
('project way', '2019-03-28 16:37:12', 'dion'),
('project way', '2019-03-28 16:40:23', 'jacky'),
('project way', '2019-03-28 16:40:37', 'moses'),
('project way', '2019-03-28 16:42:12', 'dion'),
('project way', '2019-03-28 16:45:23', 'jacky'),
('project way', '2019-03-28 16:45:37', 'moses'),
('project way', '2019-03-28 16:47:12', 'dion'),
('project way', '2019-03-28 16:50:23', 'jacky'),
('project way', '2019-03-28 16:50:37', 'moses'),
('project way', '2019-03-28 16:52:12', 'dion'),
('project way', '2019-03-28 16:55:23', 'jacky'),
('project way', '2019-03-28 16:55:37', 'moses'),
('project way', '2019-03-28 16:57:12', 'dion'),
('project way', '2019-03-28 17:00:23', 'jacky'),
('project way', '2019-03-28 17:00:37', 'moses'),
('project way', '2019-03-28 17:02:12', 'dion'),
('project way', '2019-03-28 17:05:23', 'jacky'),
('project way', '2019-03-28 17:05:37', 'moses'),
('project way', '2019-03-28 17:07:12', 'dion'),
('project way', '2019-03-28 17:10:23', 'jacky'),
('project way', '2019-03-28 17:10:37', 'moses'),
('project way', '2019-03-28 17:12:12', 'dion'),
('project way', '2019-03-28 17:15:23', 'jacky'),
('project way', '2019-03-28 17:15:37', 'moses'),
('project way', '2019-03-28 17:17:12', 'dion'),
('project way', '2019-03-28 17:20:23', 'jacky'),
('project way', '2019-03-28 17:20:37', 'moses'),
('project way', '2019-03-28 17:22:12', 'dion'),
('project way', '2019-03-28 17:25:23', 'jacky'),
('project way', '2019-03-28 17:25:37', 'moses'),
('project way', '2019-03-28 17:27:12', 'dion'),
('project way', '2019-03-28 17:30:23', 'jacky'),
('project way', '2019-03-28 17:30:37', 'moses'),
('project way', '2019-03-28 17:32:12', 'dion'),
('project way', '2019-03-28 17:35:23', 'jacky'),
('project way', '2019-03-28 17:35:37', 'moses'),
('project way', '2019-03-28 17:37:12', 'dion'),
('project way', '2019-03-28 17:40:23', 'jacky'),
('project way', '2019-03-28 17:40:37', 'moses'),
('project way', '2019-03-28 17:42:12', 'dion'),
('project way', '2019-03-28 17:45:23', 'jacky'),
('project way', '2019-03-28 17:45:37', 'moses'),
('project way', '2019-03-28 17:47:12', 'dion'),
('project way', '2019-03-28 17:50:23', 'jacky'),
('project way', '2019-03-28 17:50:37', 'moses'),
('project way', '2019-03-28 17:52:12', 'dion'),
('project way', '2019-03-28 17:55:23', 'jacky'),
('project way', '2019-03-28 17:55:37', 'moses'),
('project way', '2019-03-28 17:57:12', 'dion'),
('project way', '2019-03-28 18:00:23', 'jacky'),
('project way', '2019-03-28 18:00:37', 'moses'),
('project way', '2019-03-28 18:02:12', 'dion'),
('project way', '2019-03-28 18:05:23', 'jacky'),
('project way', '2019-03-28 18:05:37', 'moses'),
('project way', '2019-03-28 18:07:12', 'dion'),
('project way', '2019-03-28 18:10:23', 'jacky'),
('project way', '2019-03-28 18:10:37', 'moses'),
('project way', '2019-03-28 18:12:12', 'dion'),
('project way', '2019-03-28 18:15:23', 'jacky'),
('project way', '2019-03-28 18:15:37', 'moses'),
('project way', '2019-03-28 18:17:12', 'dion'),
('project way', '2019-03-28 18:20:23', 'jacky'),
('project way', '2019-03-28 18:20:37', 'moses'),
('project way', '2019-03-28 18:22:12', 'dion'),
('project way', '2019-03-28 18:25:23', 'jacky'),
('project way', '2019-03-28 18:25:37', 'moses'),
('project way', '2019-03-28 18:27:12', 'dion'),
('project way', '2019-03-28 18:30:23', 'jacky'),
('project way', '2019-03-28 18:30:37', 'moses'),
('project way', '2019-03-28 18:32:12', 'dion'),
('project way', '2019-03-28 18:35:23', 'jacky'),
('project way', '2019-03-28 18:35:37', 'moses'),
('project way', '2019-03-28 18:37:12', 'dion'),
('project way', '2019-03-28 18:40:23', 'jacky'),
('project way', '2019-03-28 18:40:37', 'moses'),
('project way', '2019-03-28 18:42:12', 'dion'),
('project way', '2019-03-28 18:45:23', 'jacky'),
('project way', '2019-03-28 18:45:37', 'moses'),
('project way', '2019-03-28 18:47:12', 'dion'),
('project way', '2019-03-28 18:50:23', 'jacky'),
('project way', '2019-03-28 18:50:37', 'moses'),
('project way', '2019-03-28 18:52:12', 'dion'),
('project way', '2019-03-28 18:55:37', 'moses'),
('project way', '2019-03-28 18:57:12', 'dion'),
('project way', '2019-03-28 19:00:37', 'moses'),
('project way', '2019-03-28 19:02:12', 'dion'),
('project way', '2019-03-28 19:05:37', 'moses'),
('project way', '2019-03-28 19:07:12', 'dion'),
('project way', '2019-03-28 19:10:37', 'moses'),
('project way', '2019-03-28 19:12:12', 'dion'),
('project way', '2019-03-28 19:15:37', 'moses'),
('project way', '2019-03-28 19:17:12', 'dion');

-- --------------------------------------------------------

--
-- Table structure for table `schedule`
--

DROP TABLE IF EXISTS `schedule`;
CREATE TABLE IF NOT EXISTS `schedule` (
  `location` varchar(20) NOT NULL,
  `startDateTime` datetime NOT NULL,
  `endDateTime` datetime NOT NULL,
  `eid` varchar(10) NOT NULL,
  PRIMARY KEY (`location`,`startDateTime`,`endDateTime`,`eid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `schedule`
--

INSERT INTO `schedule` (`location`, `startDateTime`, `endDateTime`, `eid`) VALUES
('labs', '2019-03-20 12:00:00', '2019-03-20 16:00:00', '2'),
('project way', '2019-03-18 12:00:00', '2019-03-18 16:00:00', '1');

-- --------------------------------------------------------

--
-- Table structure for table `visitor`
--

DROP TABLE IF EXISTS `visitor`;
CREATE TABLE IF NOT EXISTS `visitor` (
  `email` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `age` int(11) NOT NULL,
  `gender` char(1) NOT NULL,
  `password` varchar(60) NOT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `visitor`
--

INSERT INTO `visitor` (`email`, `name`, `age`, `gender`, `password`) VALUES
('dion', 'dion', 23, 'M', '$2a$10$R4gMEh/ywZNDguuetuqmAu5Zb.e.trYoNTjd1x9OsiDafSasncQCO'),
('jacky', 'jacky', 23, 'M', '$2a$10$0unTedFd3DR2/KF9ZMIhfeK/DTLJ1ksKj1JQEN7Am/20w0VWT6v5C'),
('moses', 'moses', 23, 'M', '$2a$10$80VZuswuzaeKnzFzTjqpNOwRdZ0mbKg/tkrn6WAHqV4og3UDvNju2');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
