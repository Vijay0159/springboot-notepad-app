(function () {
    const currentTheme = localStorage.getItem("theme") || "light";
    document.documentElement.setAttribute("data-theme", currentTheme);
    document.getElementById("themeDropdown").value = currentTheme;

    window.changeTheme = function (selectedTheme) {
        document.documentElement.setAttribute("data-theme", selectedTheme);
        localStorage.setItem("theme", selectedTheme);
    };
})();
