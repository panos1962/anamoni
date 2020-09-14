"use strict";

const anamoni = require('../lib/anamoniServer.js');
const http = require('http');

const server = {
	"port": 12345,
};

server.start = () => {
	server.ouraArray = [];
	server.ouraLista = {};

	anamoni.query('SELECT * FROM `oura` ORDER BY `ipiresia`, `kodikos`', (result) => {
		result.forEach((s) => {
			let ipiresia;

			server.ouraArray.push(s = new anamoni.oura(s));

			ipiresia = s.ipiresiaGet();

			if (!server.ouraLista.hasOwnProperty(ipiresia))
			server.ouraLista[ipiresia] = {};

			server.ouraLista[ipiresia][s.kodikosGet()] = s;
		});

		http.createServer((req, res) => {
console.log(req.url);
	
			res.writeHead(200, {'Content-Type': 'text/json'});
			res.write(JSON.stringify(server.ouraLista));
			res.end();
		}).listen(server.port);
	});
};

server.stop = () => {
	anamoni.db.end();
};

server.start();
