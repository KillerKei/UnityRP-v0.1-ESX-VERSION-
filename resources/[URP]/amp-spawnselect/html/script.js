let defaultSpawns = {
    PinkCage: {name: "Pink Cage", location: "B23", class: "Middle"},
    TrainStation: {name: "Train Station", location: "B31", class: "Middle"},
    BusStation: {name: "Bus Station", location: "B24", class: "Middle"},
    Pier: {name: "Pier", location: "D10", class: "TopRight"},
    Sandy: {name: "Sandy Shores", location: "A12", class: "BottomRight"},
    Vinewood: {name: "Vinewood", location: "B29", class: "TopRight"},
    Paleto: {name: "Paleto", location: "A16", class: "BottomLeft"},
    MazeBankArena: {name: "Maze Bank Arena", location: "B32", class: "BottomRight"},
}

$(document).ready(function() {
    $(".gridblock").on("click", ".info", function() {
        let location = $(this).attr("data-id");
        if (!location) return;
        $.post("http://amp-spawnselect/SpawnPlayer", JSON.stringify({
            location: location
        }));
        $("#mapcontainer").fadeOut(1000);
    });

});

window.addEventListener("message", function(event) {

    let action = event.data.action;

    if (action == "open") {
        clearGrid();
        loadDefaultSpawns();
        loadOwnedHousing(event.data.houses);
        $("#mapcontainer").fadeIn(2000);
    }

});

function loadDefaultSpawns() {
    for (let spawn in defaultSpawns) {
        if ($(`#${defaultSpawns[spawn].location}`).find(".spawnselection").length == 0) {
            $(`#${defaultSpawns[spawn].location}`).append(`<div class="spawnselection tooltip ${defaultSpawns[spawn].class}"><div class="info" data-id="${defaultSpawns[spawn].name}">${defaultSpawns[spawn].name}</div></div>`);
        } else {
            $(`#${defaultSpawns[spawn].location}`).find(".spawnselection").append(`<div class="info" data-id="${defaultSpawns[spawn].name}">${defaultSpawns[spawn].name}</div>`);
        }
    }
}

function loadOwnedHousing(houses) {
    for (let house in houses) {
        if ($(`#${houses[house].grid}`).find(".spawnselection").length == 0) {
            $(`#${houses[house].grid}`).append(`<div class="spawnselection tooltip ${houses[house].gridtip}"><div class="info" data-id="${houses[house].name}">${houses[house].name}</div></div>`);
        } else {
            $(`#${houses[house].grid}`).find(".spawnselection").append(`<div class="info" data-id="${houses[house].name}">${houses[house].name}</div>`);
        }
    }
}

function clearGrid() {
    let grids = ["A", "B", "C", "D"]
    for (let grid of grids) {
        for (var i = 1; i <= 35; i++) {
            $(`#${grid + i}`).html("");
        }
    }
}