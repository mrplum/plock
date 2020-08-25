/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
require("packs/custom/require")
require("./template/jquery/jquery.min")
require("./template/bootstrap/bootstrap.bundle.min")
require("./template/jquery-easing/jquery.easing.min")
require("./template/sb-admin-2.min")
require("./template/datatables/jquery.dataTables.min")
require("datatables.net")
require("datatables.net-dt")
require("./template/datatables/dataTables.bootstrap4.min")
require("./template/chart/Chart.min")
require("./template/fullcalendar/main.min")

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

import '../stylesheets/application'
