function showProfile() {
    check = document.querySelector(".showProfile").style;
    if (check.display == "block")
        check.display = "none"
    else
        check.display = "block"
}

function menuHighlight(menu) {
    document.querySelectorAll("#menu-panel").forEach((value) => {
        value.className = " ";
    })
    menu.className = "is-active";
}