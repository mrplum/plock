document.onreadystatechange = () => { 
  if (document.readyState === 'complete') {
    
    if (document.getElementById('about-user-button') !== null) {
      let buttonAboutUser = document.getElementById('about-user-button')
      buttonAboutUser.addEventListener('click', function(event){
        event.preventDefault();
        startButton("about-user","project-user","statics-user")
      });
    }
    
    if (document.getElementById('project-user-button') !== null) {
      let buttonProjectUser = document.getElementById('project-user-button')
      buttonProjectUser.addEventListener('click', function(event){
        event.preventDefault();
        startButton("project-user","statics-user","about-user")          
      });
    }

    if (document.getElementById('statics-user-button') !== null) {
      let buttonStaticsUser = document.getElementById('statics-user-button')
      buttonStaticsUser.addEventListener('click', function(event){
        event.preventDefault();
        startButton("statics-user","about-user","project-user")
      });    
    }

    if (document.getElementById('about-project-button') !== null) {
      let buttonAboutProject = document.getElementById('about-project-button')
      buttonAboutProject.addEventListener('click', function(event){
        event.preventDefault();
        startButton("about-project","track-project","statics-project")
      });
    }

    if (document.getElementById('track-project-button') !== null) {
      let buttonTrackProject = document.getElementById('track-project-button')
      buttonTrackProject.addEventListener('click', function(event){
        event.preventDefault();
        startButton("track-project","statics-project","about-project")          
      }); 
    }

    if (document.getElementById('statics-project-button') !== null) {
      let buttonStaticsProject = document.getElementById('statics-project-button')
      buttonStaticsProject.addEventListener('click', function(event){
        event.preventDefault();
        startButton("statics-project","about-project","track-project")
      });  
    }    

    }
  }
  
  function startButton(name1,name2,name3){
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
  }