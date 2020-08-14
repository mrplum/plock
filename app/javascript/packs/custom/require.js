document.onreadystatechange = () => {
  if (document.readyState === 'complete') {
    require("packs/custom/sidebar")
    require("packs/custom/home_index")
    require("packs/custom/datatables")
    require("packs/custom/flash")
    require("packs/custom/chart-bar")
    require("packs/custom/chart-pie")
    require("packs/custom/chart-area")
  }
}