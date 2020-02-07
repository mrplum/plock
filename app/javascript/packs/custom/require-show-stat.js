document.onreadystatechange = () => {
    if (document.readyState === 'complete') {
        require("packs/custom/stats_show")
        require("packs/custom/button_show_stat")
    }
}