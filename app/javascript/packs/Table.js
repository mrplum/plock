import React from 'react'

const model_table_header = function(models){
  let model = models[0];
  let header = '<tr>';
  for (var key of Object.keys(model)) {
    if (key !== 'created_at' && key.toString() !== 'updated_at')
      header = header + `<th>${key}</th>`;
  }
  header = header + '</tr>';
  document.getElementById('table-header').innerHTML = header;
}

const model_table = function (models) {
  let table_rows = ''
  models.forEach(model => {
    table_rows = table_rows + model_row(model);
    document.getElementById('table-body').innerHTML = table_rows;
  });
}

const model_row = function (model) {
  let row = '<tr>';
  for (var key of Object.keys(model)) {
    if (key !== 'created_at' && key.toString() !== 'updated_at')
      row = row + `<th>${model[key]}</th>`;
  }
  row = row + '</tr>'
  return row;
}


const Table = props => {
  return(
    <div>
      <table className='admin-table'>
        <thead id='table-header'>
          {props.models.forEach( models => model_table_header(models)) }
        </thead>
        <tbody id='table-body'>
          {props.models.forEach( models => model_table(models)) }
        </tbody>
      </table>
    </div>
  )
}

export default Table;