import React from 'react'

const Header = props => {
  return(    
    <nav className="navbar navbar-expand-lg navbar navbar-dark bg-dark">
        <a className="navbar-brand" href="/admin"> <b> Plock Admin Dashboard</b> </a>
        <div className="navbar-nav ml-auto"></div>
    </nav>
  )
}

export default Header;