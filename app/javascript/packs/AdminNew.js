import React from 'react'
import ReactDOM from 'react-dom'
import Form from './Form'
import Header from './Header'
import Footer from './Footer'

const AdminNew = props => {
  return(
    <div>
      <Header />
      <Form model={props.model}/>
      <Footer />
    </div>
  )
}

document.addEventListener('DOMContentLoaded', () => {
  const node = document.getElementById('model_data');
  const data = JSON.parse(node.getAttribute('data'));
  ReactDOM.render(
    <AdminNew model={data}/>,
    document.body.appendChild(document.createElement('div')),
  )
})