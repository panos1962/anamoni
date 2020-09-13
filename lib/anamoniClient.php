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
// www/lib/anamoniClient.php —— Βασική PHP βιβλιοθήκη για client εφαρμογές.
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

if (!class_exists("pandoraCore"))
require_once(PANDORA_BASEDIR . "/lib/pandoraCore.php");

if (!class_exists("pandora"))
require_once(PANDORA_BASEDIR . "/www/lib/pandora.php");

if (!class_exists("anamoniCore"))
require_once(ANAMONI_BASEDIR . "/www/lib/anamoniCore.php");

define("ANAMONI_SESSION_IPALILOS", "anamoni_session_ipalilos");

class anamoni extends anamoniCore {
	private static $init_ok = FALSE;

	public static function init() {
		if (self::$init_ok)
		return;

		self::$init_ok = TRUE;

		if (!isset($_SERVER))
		exit(0);
	}

	public static function is_xristis() {
		return pandora::session_get(ANAMONI_SESSION_IPALILOS);
	}

	public static function oxi_xristis() {
		return !self::is_xristis();
	}
}

anamoni::init();
