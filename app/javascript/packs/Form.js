import React, { useState, useEffect } from 'react'

const Form = props => {
  const [users, setUsers] = useState();
  const [user, setUser] = useState('');

  async function fetchUsers() {
    const users_fetch = await fetch("http://localhost:3000/admin/stadistics/users/user_select");
    users_fetch
      .json()
      .then(res => {
        let select = document.getElementById("users_select");
        res.forEach(element => {
          let option = document.createElement("option");
          option.text = element[0];
          option.value = element[1];          
          select.add(option);  
        });        
      });
  }

  useEffect(() => {
    fetchUsers();
  }, [user]);

  return(
    <div className='admin-form'> 
      <form action='/admin/stadistics/companies' method='POST' id='admin-form'>
        
        <div className="field">
          <label>Name</label>
          <input type="text" name="company[name]" />
        </div> 
        <div className="field">
          <label>Description</label>
          <input type="text" name="company[description]" />
        </div> 
        <div className="field">
          <label>User</label>
          <select id="users_select" name="company[user_id]" />
        </div>
        
        <div className="actions">
          <button type="submit">Create</button>
          <a href="/admin">
            <button>Back</button>
          </a>
        </div>
      </form>
    </div>
  )
}

export default Form;