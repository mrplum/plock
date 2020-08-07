import React from 'react'

const Model = props => {
	return(
		<div className='box'>
			<div className='model-count'>
				{props.count !== undefined ? props.count.toString().padStart(4,'0') : ''}
			</div>
			<a href={`/admin/stadistics/${props.name.toLowerCase()}`}>
				<div className='model-name'>
					{props.name}
				</div>
			</a>
			<div className='add-button'>
				<a href={`/admin/stadistics/${props.name.toLowerCase()}/new`}>New</a>
			</div>
			<div className='list-button'>
				<a href={`/admin/stadistics/${props.name.toLowerCase()}`}>Show All</a>
			</div>
		</div>
	)
}

export default Model;