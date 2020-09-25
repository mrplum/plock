import React from "react";

const TracksSummary = (props) => {

  return (
    <div className="row">

      { props.summary.map( (item, index) => (
        <div className="col-xl-3 col-md-6 mb-4" key={index}>
          <div className={`card border-left-${item.color} shadow h-100 py-2`}>
            <div className="card-body">
              <div className="row no-gutters align-items-center">
                <div className="col mr-2">
                  <div className={`text-xs font-weight-bold text-${item.color} text-uppercase mb-1`}>{item.name}</div>
                  <div className="h5 mb-0 font-weight-bold text-gray-800">{item.count}</div>
                </div>
                <div className="col-auto">
                  <i className={`fas ${item.icon} fa-2x text-gray-300`}></i>
                </div>
              </div>
            </div>
          </div>
        </div>
      )) }
      
    </div>
  );
}

export default TracksSummary;