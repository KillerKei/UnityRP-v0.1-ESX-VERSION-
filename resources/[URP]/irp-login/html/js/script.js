var characters = {}


$(document).ready(function() {

    $("#character1").click(function() {
        let cid = $(this).data("cid");
        $.post("http://irp-login/activeChar", JSON.stringify({
            id: 1,
            cid: cid,
            status: true
        }));
        $("#showCharacter").data("id", 1)
        $("#showCharacter").data("cid", cid)
        BoxInfo(1)
    });
    
    $("#character2").click(function() {
        let cid = $(this).data("cid");
        $.post("http://irp-login/activeChar", JSON.stringify({
            id: 2,
            cid: cid,
            status: true
        }));
        $("#showCharacter").data("id", 2)
        $("#showCharacter").data("cid", cid)
        BoxInfo(2)
    });

    $("#character3").click(function() {
        let cid = $(this).data("cid");
        $.post("http://irp-login/activeChar", JSON.stringify({
            id: 3,
            cid: cid,
            status: true
        }));

        $("#showCharacter").data("id", 3)
        $("#showCharacter").data("cid", cid)
        BoxInfo(3)
    });

    $("#character4").click(function() {
        let cid = $(this).data("cid");
        $.post("http://irp-login/activeChar", JSON.stringify({
            id: 4,
            cid: cid,
            status: true
        }));
        $("#showCharacter").data("id", 4)
        $("#showCharacter").data("cid", cid)
        BoxInfo(4)
    });

    $("#character5").click(function() {
        let cid = $(this).data("cid");
        $.post("http://irp-login/activeChar", JSON.stringify({
            id: 5,
            cid: cid,
            status: true
        }));
        $("#showCharacter").data("id", 5)
        $("#showCharacter").data("cid", cid)
        BoxInfo(5)
    });


    /* HOVER */

    $("#character1").hover(function() {
        let cid = $(this).data("cid");
        if (cid == "new"){
            $(this).find(".characterIcon").attr('style', 'color: rgb(207, 60, 153)');
        }
        $.post("http://irp-login/hoveredChar", JSON.stringify({
            id: 1,
            cid: cid
        }));
    });

    $("#character2").hover(function() {
        let cid = $(this).data("cid");
        if (cid == "new"){
            $(this).find(".characterIcon").attr('style', 'color: rgb(207, 60, 153)');
        }
        $.post("http://irp-login/hoveredChar", JSON.stringify({
            id: 2,
            cid: cid
        }));
    });

    $("#character3").hover(function() {
        let cid = $(this).data("cid");
        if (cid == "new"){
            $(this).find(".characterIcon").attr('style', 'color: rgb(207, 60, 153)');
        }
        $.post("http://irp-login/hoveredChar", JSON.stringify({
            id: 3,
            cid: cid
        }));
    });

    $("#character4").hover(function() {
        let cid = $(this).data("cid");
        if (cid == "new"){
            $(this).find(".characterIcon").attr('style', 'color: rgb(207, 60, 153)');
        }
        $.post("http://irp-login/hoveredChar", JSON.stringify({
            id: 4,
            cid: cid
        }));
    });

    $("#character5").hover(function() {
        let cid = $(this).data("cid");
        if (cid == "new"){
            $(this).find(".characterIcon").attr('style', 'color: rgb(207, 60, 153)');
        }
        $.post("http://irp-login/hoveredChar", JSON.stringify({
            id: 5,
            cid: cid
        }));
    });

    /* MOUSE OUT */

    $("#character1").mouseout(function() {
        if ($("#showCharacter").is(':visible')) return;
        let cid = $(this).data("cid");
        if (cid == "new"){
            $(this).find(".characterIcon").attr('style', 'color: rgba(255, 255, 255, 0.6)');
        }
        $.post("http://irp-login/unhoverChar", JSON.stringify({
            id: 1
        }));
    });

    $("#character2").mouseout(function() {
        let cid = $(this).data("cid");
        if (cid == "new"){
            $(this).find(".characterIcon").attr('style', 'color: rgba(255, 255, 255, 0.6)');
        }
        if ($("#showCharacter").is(':visible')) return;
        $.post("http://irp-login/unhoverChar", JSON.stringify({
            id: 2
        }));
    });

    $("#character3").mouseout(function() {
        let cid = $(this).data("cid");
        if (cid == "new"){
            $(this).find(".characterIcon").attr('style', 'color: rgba(255, 255, 255, 0.6)');
        }
        if ($("#showCharacter").is(':visible')) return;
        $.post("http://irp-login/unhoverChar", JSON.stringify({
            id: 3
        }));
    });

    $("#character4").mouseout(function() {
        let cid = $(this).data("cid");
        if (cid == "new"){
            $(this).find(".characterIcon").attr('style', 'color: rgba(255, 255, 255, 0.6)');
        }
        if ($("#showCharacter").is(':visible')) return;
        $.post("http://irp-login/unhoverChar", JSON.stringify({
            id: 4
        }));
    });

    $("#character5").mouseout(function() {
        let cid = $(this).data("cid");
        if (cid == "new"){
            $(this).find(".characterIcon").attr('style', 'color: rgba(255, 255, 255, 0.6)');
        }
        if ($("#showCharacter").is(':visible')) return;
        $.post("http://irp-login/unhoverChar", JSON.stringify({
            id: 5
        }));
    });

    /*  SHOW CHARACTER BUTTONS */

    $("#play-button-1").click(function() {
        $("#showCharacter").hide()
        $.post("http://irp-login/selectCharacter", JSON.stringify({
            id: Number($("#showCharacter").data("id")),
            cid: $("#showCharacter").data("cid")
        }));
    });

    $("#delete-button-1").click(function() {
        $("#showCharacter").hide()
        let id = $("#showCharacter").data("id");
        DeleteBox(id)
    });

    $("#close-button-1").click(function() {
        HideAll()
        $.post("http://irp-login/inactiveChar", JSON.stringify({
            id: "all",
            status: false
        }));
    });

    /* DELETE CHARACTER BUTTONS */

    $("#confirm-button-1").click(function() {
        for (var i = 1; i <= 5; i++) {
            $("#character" + i).html("");
            $("#character" + i).html('<i class="far fa-plus-square characterIcon"></i>');
        }
        HideAll()
        $.post("http://irp-login/deleteCharacter", JSON.stringify({
            cid: $("#showCharacter").data("cid")
        }));
    });

    $("#dc-close-btn").click(function() {
        HideAll()
        $.post("http://irp-login/inactiveChar", JSON.stringify({
            id: "all",
            status: false
        }));
    });

    /* CREATE CHARACTER FORM */

    $("#submit-button").click(function() {
        $("#content").hide();
        $.post("http://irp-login/newCharacter", JSON.stringify({
            firstname: $("#firstname").val(),
            lastname: $("#lastname").val(),
            dateofbirth: $("#dob").val(),
            sex: ($("#gender").val() == "Male") ? "m" : "f",
        }));
        HideAll()
    });

    $("#cc-close-btn").click(function() {
        $.post("http://irp-login/inactiveChar", JSON.stringify({
            id: "all",
            status: false
        }));
        HideAll()
    });

    window.addEventListener("message", function(event) {
        var action = event.data.action;
        if (action == "showLogo") {
            $("body").show();
            $(".logo-glitch").show();
            $("#content").hide()
            HideAll()
        }
        if (action == "closeScreen") {
            $(".logo-glitch").hide();
            $("#content").hide();
            HideAll()
        }
        if (action == "startScreen") {
            $(".logo-glitch").hide();
            characters = JSON.parse(event.data.characters);
            for (let i = 0; i < characters.length; i++) {
                $("#character" + (i+1)).html("")
                $("#character" + (i+1)).attr("data-cid", characters[i].cid)
                $("#character" + (i+1)).attr("data-charname", characters[i].charactername)
            }
            $("#content").show()
        }
    
        if (action == "close") {
            $("#content").hide();
            $(".logo-glitch").hide();
            $("body").hide();
            HideAll()
        }
    
    });

});

function BoxInfo(deets) {
    if (characters[deets-1]) {
        $("#delCharacter").hide();
        $("#newCharacter").hide();

        $("#showCharacter").show();

        $('#c-name').html(characters[deets-1].charactername);
        $('#c-cid').html(characters[deets-1].cid);
        $('#c-gender').html((characters[deets-1].sex === 'm') ? 'Male' : (characters[deets-1].sex === 'f') ? 'Female' : 'Unknown');
        var dateString = new Date(characters[deets-1].dob).toLocaleString('en-US');
        $('#c-dob').html(dateString.substring(0, dateString.length - 13));
        $('#c-cash').html('$' + characters[deets-1].cash);
        $('#c-bank').html('$' + characters[deets-1].bank);
        $('#c-job').html(characters[deets-1].job);

    } else {
        showCreateCharacter()

    }
}

function DeleteBox(deets) {
    $("#newCharacter").hide();
    $("#showCharacter").hide();

    $("#delCharacter").show();

    $("#showCharacter").data("cid", characters[deets-1].cid)
    $('#dc-name').html(characters[deets-1].charactername);
    $('#c-del-charname').html(characters[deets-1].charactername);
    $('#c-del-cid').html('(CID: ' + characters[deets-1].cid + ')');
}

function showCreateCharacter(){
    $("#showCharacter").hide();
    $("#delCharacter").hide();

    $("#newCharacter").show();

    $("#firstname").val("");
    $("#lastname").val("");
    $("#dob").val("");
    $("#gender").val("Male");
}

function HideAll() {
    $("#showCharacter").hide();
    $("#delCharacter").hide();
    $("#newCharacter").hide();
}

function Wait(ms) {
    return new Promise(resolve => setTimeout(resolve, ms));
}
