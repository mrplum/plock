
startButton("about-user-button","about-user","project-user","statics-user","team-user")
startButton("team-user-button","team-user","project-user","statics-user","about-user")
startButton("project-user-button","project-user","team-user","statics-user","about-user")
startButton("statics-user-button","statics-user","about-user","team-user","project-user")
startButton("about-project-button","about-project","track-project","statics-project")
startButton("track-project-button","track-project","statics-project","about-project")
startButton("statics-project-button","statics-project","about-project","track-project")
startButton("about-track-button","about-track","track-interval")
startButton("track-interval-button","track-interval","about-track")
startButton("about-company-button","about-company","company-user","company-project","team-company")
startButton("company-user-button","company-user","company-project","about-company","team-company")
startButton("company-project-button","company-project","about-company","company-user","team-company")
startButton("company-team-button","team-company","company-project","about-company","company-user")
 
function startButton(idDoc, name1, name2, name3 = "", name4 = ""){
  if (document.getElementById(idDoc) !== null) {
    let button = document.getElementById(idDoc)
    button.addEventListener('click', function(event){
      event.preventDefault();
      if (document.getElementById(name1).classList.contains('hidden') &&
        !document.getElementById(name2).classList.contains('hidden')){
          document.getElementById(name2).classList.add('hidden')
          document.getElementById(name1).classList.remove('hidden')
      }  
      else if (document.getElementById(name1).classList.contains('hidden') &&
        !document.getElementById(name3).classList.contains('hidden')){
          document.getElementById(name3).classList.add('hidden')
          document.getElementById(name1).classList.remove('hidden')
      }
      else if (document.getElementById(name1).classList.contains('hidden') &&
        !document.getElementById(name4).classList.contains('hidden')){
          document.getElementById(name4).classList.add('hidden')
          document.getElementById(name1).classList.remove('hidden')
      }
    });
  }
}
