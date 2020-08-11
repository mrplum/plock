document.onreadystatechange = () => {
  if (document.readyState === 'complete') {
    require("packs/custom/button_show_new_interval")
    require("packs/custom/stats_show")
    require("packs/custom/home_index")
    require("packs/custom/datatables")
    require("packs/custom/flash")
  }
}