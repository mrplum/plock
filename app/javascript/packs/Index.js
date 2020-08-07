import React, { useState, useEffect } from 'react'
import ReactDOM from 'react-dom'
import Table from './Table'
import ModelList from './ModelList'
import Footer from './Footer'
import Header from './Header'

const Index = props => {
  const [records, setRecords] = useState([]);
  const [user, setUser] = useState('')

  async function fetchRecords() {
    const records_fetch = await fetch(`http://localhost:3000/admin/stadistics/${props.record}/${props.record}_table`);
    records_fetch
      .json()
      .then(res => {
        setRecords([...records, res])
      });
  }

  useEffect(() => {
    fetchRecords();
  }, [user]);

  return(
    <div>
      <Header />
      <Table models={records} />
      <Footer />
    </div>
  )
}

document.addEventListener('DOMContentLoaded', () => {
  const node = document.getElementById('record_name');
  const data = JSON.parse(node.getAttribute('data'));
  ReactDOM.render(
    <Index record={data}/>,
    document.body.appendChild(document.createElement('div')),
  )
})