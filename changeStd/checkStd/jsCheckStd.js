function showProfile() {
    check = document.querySelector(".showProfile").style;
    if (check.display == "block")
        check.display = "none"
    else
        check.display = "block"
}

function check_all() {
    std = document.querySelectorAll("[name = 'checkStd']");
    std.forEach((value) => {
        value.checked = true;
    })

}