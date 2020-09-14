(function(){function r(e,n,t){function o(i,f){if(!n[i]){if(!e[i]){var c="function"==typeof require&&require;if(!f&&c)return c(i,!0);if(u)return u(i,!0);var a=new Error("Cannot find module '"+i+"'");throw a.code="MODULE_NOT_FOUND",a}var p=n[i]={exports:{}};e[i][0].call(p.exports,function(r){var n=e[i][1][r];return o(n||r)},p,p.exports,r,e,n,t)}return n[i].exports}for(var u="function"==typeof require&&require,i=0;i<t.length;i++)o(t[i]);return o}return r})()({1:[function(require,module,exports){
"use strict";

const anamoni = require('./anamoniCore.js');

module.exports = anamoni;

},{"./anamoniCore.js":2}],2:[function(require,module,exports){
const anamoni = {};
module.exports = anamoni;

anamoni.oura = function(props) {
	for (i in props)
	this[i] = props[i];
};

anamoni.oura.prototype.kodikosSet = function(kodikos) {
	this.kodikos = kodikos;
	return this;
};

anamoni.oura.prototype.kodikosGet = function() {
	return this.kodikos;
};

anamoni.oura.prototype.ipiresiaSet = function(ipiresia) {
	this.ipiresia = ipiresia;
	return this;
};

anamoni.oura.prototype.ipiresiaGet = function() {
	return this.ipiresia;
};

anamoni.oura.prototype.perigrafiSet = function(perigrafi) {
	this.perigrafi = perigrafi;
	return this;
};

anamoni.oura.prototype.perigrafiGet = function() {
	return this.perigrafi;
};

anamoni.oura.prototype.infoSet = function(info) {
	this.info = info;
	return this;
};

anamoni.oura.prototype.infoGet = function() {
	return this.info;
};

anamoni.oura.prototype.siraSet = function(sira) {
	this.sira = sira;
	return this;
};

anamoni.oura.prototype.siraGet = function() {
	return this.sira;
};

},{}],3:[function(require,module,exports){
"use strict";

$(window).ready(function() {
	Konsola.init();
});

$(document).ready(function() {
	Konsola.init();
});

///////////////////////////////////////////////////////////////////////////////@

const anamoni = require('../lib/anamoniClient.js');
const Konsola = {};

Konsola.initAA = 0;

Konsola.init = () => {
	Konsola.initAA++;

	if (Konsola.initAA < 2)
	return Konsola;

	delete Konsola.initaAA;
	Konsola.windowDOM = $(window);
	Konsola.bodyDOM = $(document.body);

	Konsola.ipiresiaListaDOM = $('#ipiresiaLista');

	let ilist = [];

	Konsola.ipiresiaListaDOM.
	children().
	each(function() {
		let ipiresia = $(this).children().text();

		$(this).data('ipiresia', ipiresia);
		ilist.push({
			'ipiresia': ipiresia,
			'DOM': $(this),
		});
	});

	Konsola.ipiresiaProcess(ilist);
};

Konsola.ipiresiaProcess = (ilist) => {
	let x = ilist.pop();

	if (!x)
	return Konsola.initPost();

	$.post({
		'url': 'ouraGet.php',
		'data': {
			'ipiresia': x.ipiresia,
		},
		'dataType': 'json',
		'success': (rsp) => {
			Konsola.
			ipiresiaOuraAdd(x.DOM, rsp).
			ipiresiaProcess(ilist);
		},
		'error': (err) => {
			console.error(err);
		},
	});
}

Konsola.ipiresiaOuraAdd = (idom, olist) => {
	let x;

	while (x = olist.shift()) {
		$('<div>').
		addClass('oura').
		text(x.k + '. ' + x.p).
		appendTo(idom);
	}

	return Konsola;
};

Konsola.initPost = () => {
	Konsola.bodyDOM.
	on('click', '.ipiresia', function(e) {
		e.stopPropagation();

		let icont = $(this).parent();

		if (icont.data('anikto')) {
			icont.removeData('anikto');
			icont.children('.oura').css('display', '');

			return;
		}

		icont.data('anikto', true);
		icont.children('.oura').css('display', 'block');
	});

	return Konsola;
};

///////////////////////////////////////////////////////////////////////////////@

},{"../lib/anamoniClient.js":1}]},{},[3]);
