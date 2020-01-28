import React from 'react'
import Model from './Model'

const ModelList = props => {
  return(
    <div className='model-list-container'>
      <Model name='Companies' count={props.companies} />
      <Model name='Intervals' count={props.intervals} />
      <Model name='Tracks' count={props.tracks} />
      <Model name='Users' count={props.users} />
      <Model name='Projects' count={props.projects} />
      <Model name='Teams' count={props.teams} />
    </div>
  )
}

export default ModelList;