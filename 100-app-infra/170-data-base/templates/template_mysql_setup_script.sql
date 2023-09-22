CREATE DATABASE IF NOT EXISTS ${db_name};
CREATE TABLE IF NOT EXISTS `${db_table_name}` (
  `id` bigint NOT NULL,
  `calories` int DEFAULT NULL,
  `comments` varchar(255) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `distance` double DEFAULT NULL,
  `time` time DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
CREATE USER IF NOT EXISTS '${db_workoutrecorder_username}'@'%' IDENTIFIED BY '<db_workoutrecorder_password>';
GRANT ALL PRIVILEGES ON ${db_name}.* TO '${db_workoutrecorder_username}'@'%';
CREATE TABLE IF NOT EXISTS hibernate_sequence (`next_val` BIGINT);
INSERT INTO hibernate_sequence VALUES (1);
