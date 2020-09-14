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
