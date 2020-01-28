import React, { useState, useEffect } from 'react'
import ReactDOM from 'react-dom'
import Header from './Header'
import ModelList from './ModelList'
import Footer from './Footer'

const Dashboard = props => {
  const [data, setData] = useState();
  const [user, setUser] = useState('')

  async function fetchData() {
    const companies_fetch = await fetch("http://localhost:3000/admin/models_count");
    companies_fetch
      .json()
      .then(res => setData(res));
  }

  useEffect(() => {
    fetchData();
  }, [user]);

  return(
    <div>
      <Header />
      <ModelList  {...data} />
      <Footer />
    </div>
  )
}

document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(
    <Dashboard />,
    document.body.appendChild(document.createElement('div')),
  )
})
