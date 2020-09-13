$(window).ready(function() {
	Konsola.init();
});

$(document).ready(function() {
	Konsola.init();
});

///////////////////////////////////////////////////////////////////////////////@

Konsola = {};

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
