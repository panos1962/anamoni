"use strict";

const anamoni = require('./anamoniCore.js');
anamoni.fs = require('fs');
const mysql = require('mysql');

module.exports = anamoni;

anamoni.pandoraBasedir = process.env.PANDORA_BASEDIR;

if (anamoni.pandoraBasedir === undefined)
anamoni.pandoraBasedir = '/var/opt/pandora';

anamoni.anamoniBasedir = process.env.ANAMONI_BASEDIR;

if (anamoni.anamoniBasedir === undefined)
anamoni.anamoniBasedir = '/var/opt/anamoni';

anamoni.query = (query, callback) => {
	if (anamoni.db === undefined)
	return anamoni.databaseConnect(() => {
		anamoni.query(query, callback);
	});

	anamoni.db.query(query, (err, result) => {
		if (err)
		throw err;

		callback(result);
	});
};

anamoni.databaseConnect = (callback) => {
	let dbpass;

	anamoni.fs.readFile(anamoni.pandoraBasedir + '/private/sesamidb',
		'utf8', (err, data) => {
		let con = {
			"host": "localhost",
			"database": "anamoni",
			"user": "anamoni",
		};

		if (err)
		throw err;

		data = data.split(/\n/);
		data.every((s) => {
			let x = s.split(/\t/);

			if (x[0] !== con.user)
			return true;

			con.password = x[1];
			return false;
		});

		anamoni.db = mysql.createConnection(con);
		anamoni.db.connect((err) => {
			if (err)
			throw err;

			callback();
		});
	});
};

anamoni.query('SELECT * FROM `oura`', (result) => {
	result.every((s) => {
		console.log(s.kodikos, s.perigrafi);
		return true;
	});
});
