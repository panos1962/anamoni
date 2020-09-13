<?php

///////////////////////////////////////////////////////////////////////////////@
//
// @BEGIN
//
// @COPYRIGHT BEGIN
// Copyright (C) 2020 Panos I. Papadopoulos <panos1962_AT_gmail_DOT_com>
// @COPYRIGHT END
//
// @FILETYPE BEGIN
// php
// @FILETYPE END
//
// @FILE BEGIN
// lib/anamoniCore.php —— Βασική PHP βιβλιοθήκη
// @FILE END
//
// @DESCRIPTION BEGIN
// @DESCRIPTION END
//
// @HISTORY BEGIN
// Created: 2020-09-13
// @HISTORY END
//
// @END
//
///////////////////////////////////////////////////////////////////////////////@

class anamoniCore {
	public static function database() {
		pandora::database([
			'dbhost' => 'localhost',
			'dbname' => 'anamoni',
			'dbuser' => 'anamoni',
		]);
	}
}

class Ipalilos {
	public $kodikos = NULL;
	public $onomateponimo = NULL;

	public function __construct($x = NULL) {
		$this->from_array($x);
	}

	public function kodikos_set($kodikos) {
		$this->kodikos = $kodikos;
		return $this;
	}

	public function kodikos_get() {
		return $this->kodikos;
	}

	public function onomateponimo_set($onomateponimo) {
		$this->onomateponimo = $onomateponimo;
		return $this;
	}

	public function onomateponimo_get() {
		return $this->onomateponimo;
	}

	private function from_array($x) {
		$this->kodikos = NULL;
		$this->onomateponimo = NULL;

		if (!isset($x))
		return $this;

		foreach ($x as $k => $v) {
			try {
				$func = $k . "_set";
				$this->$func($v);
			}

			catch (Exception $e) {
				continue;
			}
		}

		return $this;
	}

	public function from_database() {
		$query = "SELECT `kodikos`, `onomateponimo`" .
			" FROM `ipalilos` WHERE `kodikos` = " . $this->kodikos;
print_r($query);
		$row = pandora::first_row($query, MYSQLI_ASSOC);
		return $this->from_array($row);
	}
}

?>
