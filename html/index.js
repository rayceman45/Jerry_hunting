


function VehiclesSelected() {
    var Vehicle = document.getElementById("selectvh");
    var Weapon = document.getElementById("selectwa");
    
    Vehicle.style.display = "block";
    Weapon.style.display = "none";
      //x.style.display = "block";
    
}

function WeaponSelected() {
    var Vehicle = document.getElementById("selectvh");
    var Weapon = document.getElementById("selectwa");
    

    Weapon.style.display = "block";
    Vehicle.style.display = "none";
      //x.style.display = "block";
    
}


function askplayer() {
    var RentalBG = document.getElementById("windowBG");
    var askPlayerBG = document.getElementById("windowBG2");

    RentalBG.style.display = "none";
    askPlayerBG.style.display = "block";
}


function closeAsk() {
    var RentalBG = document.getElementById("windowBG");
    var askPlayerBG = document.getElementById("windowBG2");

    RentalBG.style.display = "block";
    askPlayerBG.style.display = "none";
}









$(function () {
    var playerAskreqlName = document.getElementById("reqName");

    function display(bool) {
        if (bool) {
            $("#shopMenu").show();
        } else {
            $("#shopMenu").hide();
        }
    }

    display(false)

    window.addEventListener('message', function(event) {
        var item = event.data;
        if (item.type === "ui") {
            if (item.status == true) {
                display(true)
            } else {
                display(false)
            }
        }
    })

    // if the person uses the escape key, it will exit the resource
    document.onkeyup = function (data) {
        if (data.which == 27) {
            $.post('http://Jerry_hunting/exit', JSON.stringify({}));
            closeAsk()
            return
        }
    };

    $("#acceptAsk").click(function () {

        closeAsk()
        $.post('http://Jerry_hunting/askAccept', JSON.stringify({}));
        return
    })

    $('#closeAsk').click(function () {
        closeAsk()
        return
    })


    $("#rentvehicle").click(function () {
        //askPlayerBG.style.display = "none";
        playerAskreqlName.innerHTML = "VEHICLE";
        VehiclesSelected()
        askplayer()

        $.post('http://Jerry_hunting/rentvehicle', JSON.stringify({}));
        return
    })

    $("#rentweapon").click(function () {
        //askPlayerBG.style.display = "none";
        playerAskreqlName.innerHTML = "WEAPON";
        WeaponSelected()
        askplayer()

        $.post('http://Jerry_hunting/rentweapon', JSON.stringify({}));
        return
    })
})