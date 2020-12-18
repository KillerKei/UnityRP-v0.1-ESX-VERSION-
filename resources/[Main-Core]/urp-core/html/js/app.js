(() => {

	URPCore = {};
	URPCore.HUDElements = [];

	URPCore.setHUDDisplay = function (opacity) {
		$('#hud').css('opacity', opacity);
	};

	URPCore.insertHUDElement = function (name, index, priority, html, data) {
		URPCore.HUDElements.push({
			name: name,
			index: index,
			priority: priority,
			html: html,
			data: data
		});

		URPCore.HUDElements.sort((a, b) => {
			return a.index - b.index || b.priority - a.priority;
		});
	};

	URPCore.updateHUDElement = function (name, data) {

		for (let i = 0; i < URPCore.HUDElements.length; i++) {
			if (URPCore.HUDElements[i].name == name) {
				URPCore.HUDElements[i].data = data;
			}
		}

		URPCore.refreshHUD();
	};

	URPCore.deleteHUDElement = function (name) {
		for (let i = 0; i < URPCore.HUDElements.length; i++) {
			if (URPCore.HUDElements[i].name == name) {
				URPCore.HUDElements.splice(i, 1);
			}
		}

		URPCore.refreshHUD();
	};

	URPCore.refreshHUD = function () {
		$('#hud').html('');

		for (let i = 0; i < URPCore.HUDElements.length; i++) {
			let html = Mustache.render(URPCore.HUDElements[i].html, URPCore.HUDElements[i].data);
			$('#hud').append(html);
		}
	};

	URPCore.inventoryNotification = function (add, item, count) {
		let notif = '';

		if (add) {
			notif += '+';
		} else {
			notif += '-';
		}

		notif += count + ' ' + item.label;

		let elem = $('<div>' + notif + '</div>');

		$('#inventory_notifications').append(elem);

		$(elem).delay(3000).fadeOut(1000, function () {
			elem.remove();
		});
	};

	window.onData = (data) => {
		switch (data.action) {
			case 'setHUDDisplay': {
				URPCore.setHUDDisplay(data.opacity);
				break;
			}

			case 'insertHUDElement': {
				URPCore.insertHUDElement(data.name, data.index, data.priority, data.html, data.data);
				break;
			}

			case 'updateHUDElement': {
				URPCore.updateHUDElement(data.name, data.data);
				break;
			}

			case 'deleteHUDElement': {
				URPCore.deleteHUDElement(data.name);
				break;
			}

			case 'inventoryNotification': {
				URPCore.inventoryNotification(data.add, data.item, data.count);
			}
		}
	};

	window.onload = function (e) {
		window.addEventListener('message', (event) => {
			onData(event.data);
		});
	};

})();