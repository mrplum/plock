document.getElementById("sidebarToggle").addEventListener("click", function() {
  if ( document.getElementById("accordionSidebar").classList.contains("toggled") )
    document.getElementById("accordionSidebar").classList.remove("toggled");
  else
    document.getElementById("accordionSidebar").classList.add("toggled");
}, false);