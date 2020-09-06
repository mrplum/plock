document.onreadystatechange = () => {
  if (document.readyState === 'complete') {
    require("packs/custom/sidebar")
    require("packs/custom/home_index")
    require("packs/custom/calendar")
    require("packs/custom/datatables")
    require("packs/custom/flash")
    require("packs/custom/preview_image")
    require("packs/custom/chart-bar")
    require("packs/custom/chart-pie")
    require("packs/custom/chart-area")
    require("packs/custom/click_tab")
  }
}