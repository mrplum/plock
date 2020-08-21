startButton("button-tracks-project","button-about-project","tracks-project","about-project")
startButton("button-about-project","button-tracks-project","about-project","tracks-project")
startButton("button-about-team","button-statistics-team","about-team","statistics-team")
startButton("button-statistics-team","button-about-team","statistics-team","about-team")
startButton("button-about-company","button-employees-company","about-company","employees-company")
startButton("button-employees-company","button-about-company","employees-company","about-company")
startButton("button-intervals-track","button-about-track","intervals-track","about-track")
startButton("button-about-track","button-intervals-track","about-track","intervals-track")

function startButton(idDoc1, idDoc2, name1, name2){
  if (document.getElementById(idDoc1) !== null) {
    let button = document.getElementById(idDoc1)
    button.addEventListener('click', function(event){
      event.preventDefault();
      if (document.getElementById(name1).classList.contains('hidden')){
        document.getElementById(name1).classList.remove('hidden')
        document.getElementById(idDoc1).classList.add('active')
        document.getElementById(name2).classList.add('hidden')
        document.getElementById(idDoc2).classList.remove('active')
      }
      else {
        document.getElementById(name2).classList.remove('hidden')
        document.getElementById(idDoc2).classList.add('active')
        document.getElementById(name1).classList.add('hidden')
        document.getElementById(idDoc1).classList.remove('active')
      }
    });
  }
}