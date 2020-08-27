import React from 'react';

import Layout from './Layout.js';

import BodyHistoryPage from './BodyHistoryPage.js';

import '../css/page.css';

class App extends React.Component {

  selectedPage() {
    return <BodyHistoryPage/>
  }

  render() {
    return (
      <div>
        <Layout/>
        <div className="pages-container">
          {this.selectedPage()}
        </div>
      </div>
    );
  }
}

export default App;
