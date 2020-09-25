import React from "react";

const Index = (props) => {
  const data = props.data;

  const replaceIdToUrl = (url, id) => {
    return url.replace("0", id);
  }

  const printDescription = (item) => {
    return item.description != undefined
    ? <p> {item.description} </p>
    : null
  }

  return (
    <div className="card shadow mb-4">
      <div className="card-header py-3">
        <h6 className="m-0 font-weight-bold text-primary"> {data.title} </h6>
      </div>
      <div className="card-body">
        { data.collection &&
          <div className="row">
            { data.collection.map( (item, index) => (
              <div className="col-xl-3 mb-4" key={index}>
                <a className="btn card shadow bg-light mb-3 border-bottom-info" href={replaceIdToUrl(data.show_url, item.id)}>
                  <div className="row">
                    <div className="card-body">
                      <div className="text-center">
                        <p> <strong> { item.name } </strong> </p>
                        { printDescription(item) }
                      </div>
                    </div>
                  </div>
                </a>
              </div>
            )) }
          </div>
        }
        { !data.collection &&
          <div className="mt-4 text-center">
            <span className="text-danger font-weight-bold">
              {data.not_data}
              <i className="fa fa-fw fa-times text-danger"></i>
            </span>
          </div>
        }
      </div>
    </div>

  );
}

export default Index;
