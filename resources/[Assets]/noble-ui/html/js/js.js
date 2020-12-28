// window.addEventListener('message', function (event) {
// 	switch (event.data.action) {
//         case 'showthermiteallert':
//             if (event.data.thermitetest == true ) {
//                 $('thermiteicon').css('visibility', 'hidden')
//             } else {
//                 $('thermiteicon').css('visibility', 'hidden')
//             }
//     }
// });

window.addEventListener('message', function (event) {
    NobleUI(event.data);
});

window.addEventListener('message', function (event) {
	let data = event.data
	if(data.action == 'animation') {
        if (data.display == true) {
            $.when($('#ui').animate({"margin-left": '+=100',}, 500).fadeIn()).done(function() {
            });
        }
    }
});

window.addEventListener('message', function (event) {
	let data = event.data
	if(data.action == 'animationEnd') {
        if (data.display == true) {
            $.when($('#ui').animate({"margin-left": '-=200',}, 500).fadeOut(20)).done(function() {
            });
        }
    }
});

window.addEventListener('message', (event) => {
	let data = event.data
	if(data.action == 'notification') {
        if (data.display == true) {
            $.when($('#ui').fadeIn()).done(function() {
            document.getElementById("ui").style.display = "block";
            });
        } else {
            $.when($('#ui').fadeOut()).done(function() {
                document.getElementById("ui").style.display = "none";
            });
        }
	}
})

function NobleUI(data) {
    $('#font').html(data.text);
}