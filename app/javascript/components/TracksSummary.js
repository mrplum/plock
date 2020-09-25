import React from "react";

const TracksSummary = (props) => {

  return (
    <div className="boxContainer">

      { props.summary.map( (item, index) => (
        <div className={`boxItem ${item.color}`} key={index}>
          <div>
            <p className={`itemName ${item.color}`}>{item.name}</p>
            <p className="itemCount">{item.count}</p>
          </div>
          <div>
            <i className={`fas ${item.icon} fa-2x text-gray-300`}></i>
          </div>
        </div>
      )) }
      
    </div>
  );
}

export default TracksSummary;