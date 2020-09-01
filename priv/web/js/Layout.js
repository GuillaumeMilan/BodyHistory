import React from 'react';

import '../css/header.css';


class Layout extends React.Component {

  render() {
    return(
      <div className="header-container">
        <div className="header-left">
          Logo
        </div>
        <div className="header-center">
          <h1> Body History </h1>
        </div>
        <div className="header-right">
        </div>
      </div>
    );
  }
}

export default Layout;
