-------------------------------------------------------------------------------@
--
-- @BEGIN
--
-- @COPYRIGHT BEGIN
-- Copyright (C) 2020 Panos I. Papadopoulos <panos1962_AT_gmail_DOT_com>
-- @COPYRIGHT END
--
-- @FILETYPE BEGIN
-- SQL
-- @FILETYPE END
--
-- @FILE BEGIN
-- database/anamoni.sql —— Data dictionary for database "anamoni"
-- @FILE END
--
-- @DESCRIPTION BEGIN
-- Το παρόν file περιέχει το schema της database "anamoni". Η database
-- "anamoni" αφορά στη διαχείριση των ουρών αναμονής εξυπηρέτησης δημοτών.
-- @DESCRIPTION END
--
-- @HISTORY BEGIN
-- Created: 2020-09-12
-- @HISTORY END
--
-- @END
--
-------------------------------------------------------------------------------@

\! [ -w /dev/tty ] && echo "\nDatabase '[[DATABASE]]'" >/dev/tty

-------------------------------------------------------------------------------@

\! [ -w /dev/tty ] && echo "Creating database…" >/dev/tty

-- Πρώτο βήμα είναι η διαγραφή της database εφόσον αυτή υπάρχει ήδη.

DROP DATABASE IF EXISTS `[[DATABASE]]`
;

-- Με το παρόν κατασκευάζουμε την database.

CREATE DATABASE `[[DATABASE]]`
DEFAULT CHARSET = utf8
DEFAULT COLLATE = utf8_general_ci
;

-- Καθιστούμε τρέχουσα την database που μόλις κατασκευάσαμε.

USE `[[DATABASE]]`
;

-- Καθορίζουμε την default storage engine για τους πίνακες που θα δημιουργηθούν.

SET default_storage_engine = INNODB
;

-------------------------------------------------------------------------------@

-- Ο πίνακας "ipalilos" περιέχει τους υπαλλήλους που εξυπηρετούν. Πρόκειται
-- για ένα μικρό υποσύνολο των υπαλλήλων του Δήμου.

CREATE TABLE `ipalilos` (
	`kodikos`	MEDIUMINT UNSIGNED NOT NULL COMMENT 'Αρ. μητρώου',
	`onomateponimo` VARCHAR(40) NOT NULL,
	`password`	CHARACTER(40) NOT NULL,

	PRIMARY KEY (
		`kodikos`
	) USING HASH
)

COMMENT = 'Πίνακας υπαλλήλων'
;

CREATE TABLE `oura` (
	`kodikos`	VARCHAR(6) NOT NULL COMMENT 'Κωδικός ουράς',
	`ipiresia`	VARCHAR(128) NOT NULL COMMENT 'Υπηρεσία',
	`perigrafi`	VARCHAR(128) NOT NULL COMMENT 'Περιγραφή αντικειμένου',
	`info`		VARCHAR(4096) NOT NULL COMMENT 'Αναλυτική περιγραφή',
	`sira`		SMALLINT UNSIGNED NULL DEFAULT NULL COMMENT 'Τρέχον νούμερο',

	PRIMARY KEY (
		`kodikos`
	) USING BTREE
)

COMMENT = 'Πίνακας ουρών αναμονής'
;

CREATE TABLE `thesi` (
	`kodikos`	VARCHAR(8) NOT NULL COMMENT 'Κωδικός θέσης',
	`oura`		VARCHAR(6) NOT NULL COMMENT 'Κωδικός ουράς',
	`ipalilos`	MEDIUMINT UNSIGNED NULL DEFAULT NULL COMMENT 'Κωδικός υπαλλήλου',
	`sira`		SMALLINT UNSIGNED NULL DEFAULT NULL COMMENT 'Νούμερο που εξυπηρετείται',

	PRIMARY KEY (
		`kodikos`
	) USING BTREE
)

COMMENT = 'Πίνακας θέσεων εξυπηρέτησης'
;

CREATE TABLE `prosvasi` (
	`ipalilos`	MEDIUMINT UNSIGNED NOT NULL COMMENT 'Κωδικός υπαλλήλου',
	`thesi`		VARCHAR(8) NOT NULL COMMENT 'Κωδικός ουράς',

	PRIMARY KEY (
		`ipalilos`,
		`thesi`
	) USING BTREE
)

COMMENT = 'Προσβάσεις θέσεων ανά υπάλληλο'
;

COMMIT WORK
;

-------------------------------------------------------------------------------@

\! [ -w /dev/tty ] && echo "Creating relations…" >/dev/tty

ALTER TABLE `prosvasi` ADD FOREIGN KEY (
	`ipalilos`
) REFERENCES `ipalilos` (
	`kodikos`
) ON UPDATE CASCADE ON DELETE CASCADE
;

ALTER TABLE `prosvasi` ADD FOREIGN KEY (
	`thesi`
) REFERENCES `thesi` (
	`kodikos`
) ON UPDATE CASCADE ON DELETE CASCADE
;

ALTER TABLE `thesi` ADD FOREIGN KEY (
	`oura`
) REFERENCES `oura` (
	`kodikos`
) ON UPDATE CASCADE ON DELETE CASCADE
;

ALTER TABLE `thesi` ADD FOREIGN KEY (
	`ipalilos`
) REFERENCES `ipalilos` (
	`kodikos`
) ON UPDATE CASCADE ON DELETE CASCADE
;

COMMIT WORK
;

-------------------------------------------------------------------------------@

\! [ -w /dev/tty ] && echo "Creating users…" >/dev/tty

DROP USER IF EXISTS '[[USERNAME]]'@'[[HOST]]'
;

CREATE USER '[[USERNAME]]'@'[[HOST]]' IDENTIFIED BY '[[USERPASS]]'
;

COMMIT WORK
;

-------------------------------------------------------------------------------@

\! [ -w /dev/tty ] && echo "Granting permissions…" >/dev/tty

GRANT SELECT, INSERT, UPDATE, DELETE
ON `[[DATABASE]]`.* TO '[[USERNAME]]'@'[[HOST]]'
;

COMMIT WORK
;

-------------------------------------------------------------------------------@

\! [ -w /dev/tty ] && echo "Inserting data…" >/dev/tty

INSERT INTO `oura` (
	`kodikos`,
	`ipiresia`,
	`perigrafi`,
	`info`
) VALUES
(
	'Δ1',
	'ΔΗΜΟΤΟΛΟΓΙΟ',
	'ΠΙΣΤΟΠΟΙΗΤΙΚΑ',
	'Πιστοποιητικά Γέννησης, Οικογενειακής Κατάστασης κλπ'
),
(
	'Δ2',
	'ΔΗΜΟΤΟΛΟΓΙΟ',
	'ΠΛΗΣΙΕΣΤΕΡΩΝ',
	'Πιστοποιητικά Πλησιεστέρων Συγγενών'
),
(
	'Δ3',
	'ΔΗΜΟΤΟΛΟΓΙΟ',
	'ΜΕΤΑΒΟΛΕΣ',
	'Γεννήσεις, Γάμοι, Διαζύγια, Θάνατοι κλπ'
),
(
	'Δ4',
	'ΔΗΜΟΤΟΛΟΓΙΟ',
	'ΠΟΛΙΤΟΓΡΑΦΗΣΕΙΣ',
	''
),
(
	'Δ5',
	'ΔΗΜΟΤΟΛΟΓΙΟ',
	'ΜΗΤΡΩΟ ΑΡΡΕΝΩΝ',
	''
),
(
	'Δ6',
	'ΔΗΜΟΤΟΛΟΓΙΟ',
	'ΕΚΛΟΓΙΚΑ',
	''
),
(
	'Δ7',
	'ΔΗΜΟΤΟΛΟΓΙΟ',
	'ΠΟΛΙΤΙΚΟΙ ΓΑΜΟΙ',
	''
),
(
	'Δ8',
	'ΔΗΜΟΤΟΛΟΓΙΟ',
	'ΟΝΟΜΑΤΕΠΩΝΥΜΙΚΑ',
	''
),
(
	'Τ1',
	'ΤΑΠ',
	'ΒΕΒΑΙΩΣΕΙΣ ΤΑΠ',
	''
),
(
	'Τ2',
	'ΤΑΠ',
	'ΜΕΤΑΒΟΛΕΣ',
	''
),
(
	'Τ3',
	'ΤΑΠ',
	'ΜΕΤΑΒΙΒΑΣΕΙΣ',
	''
);

INSERT INTO `ipalilos` (
	`kodikos`,
	`onomateponimo`,
	`password`
) VALUES
(
	3307,
	'ΠΑΠΑΔΟΠΟΥΛΟΣ ΠΑΝΑΓΙΩΤΗΣ ΙΩΑ',
	'b60d121b438a380c343d5ec3c2037564b82ffef3'
),
(
	2922,
	'ΧΑΛΜΠΑ ΜΑΡΙΑ ΒΑΪ',
	'b60d121b438a380c343d5ec3c2037564b82ffef3'
);

COMMIT WORK
;

-------------------------------------------------------------------------------@

