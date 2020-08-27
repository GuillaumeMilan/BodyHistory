import React from 'react';
const d3 = require('d3');
import {transform} from 'd3-transform'



import '../css/page.css';
import '../css/bodyhistory-page.css';

class BodyHistoryPage extends React.Component {

  constructor(props) {
    super(props)
    this.state = {
      chart_ref: undefined,
    }
  }

  initChart(ref) {
    if(this.state.chart_ref)
      return
    this.setState({d3: this.buildChart(ref), chart_ref: ref})
  }

  buildChart(ref) {

    const size = {width: 640, height: 480}

    const colors = {
      "900": "#205072",
      "700": "#329D9C",
      "500": "#56C596",
      "300": "#7BE495",
      "100": "#CFF4D2",
    }

    const svg = d3.select(ref).append("svg")
      .attr("width", size.width)
      .attr("height", size.height)
      .attr("viewBox", [0, 0, size.width, size.height].join(" "))

    const bodyFaceGroup = svg.append("g")
      .attr("transform", transform().translate([10, 90]))
    const bodyFace = bodyFaceGroup.append("path")
      .attr("fill", colors["700"])
      .attr("d", "M 57.060526,0 0,14.23591 v 33.661246 l 67.019648,10.497135 22.042277,129.247729 -23.07798,46.5094 23.07798,65.47602 h 23.078655 l 23.07866,-62.31492 -22.9057,-49.29792 h 71.67653 l -23.07865,46.51007 23.07865,65.47534 h 23.07798 L 230.1467,237.68577 207.06805,188.0146 v -0.37258 L 229.111,58.394295 296.13136,47.897159 V 14.23591 L 239.07012,0 H 207.06805 89.061925 Z")

    const labelFace = svg.append("text")
      .attr("x", 10+296/2)
      .attr("y", 80)
      .attr("font-size", "40px")
      .attr("text-anchor", "middle")
      .attr("fill", colors["900"])
      .text("Face")


    const bodyBackGroup = svg.append("g")
      .attr("transform", transform().translate([10 + 10 + 296, 90]))
    const bodyBack =  bodyBackGroup.append("path")
      .attr("fill", colors["700"])
      .attr("d", "M 57.060526,0 0,14.23591 v 33.661246 l 67.019648,10.497135 22.042277,129.247729 -23.07798,46.5094 23.07798,65.47602 h 23.078655 l 23.07866,-62.31492 -22.9057,-49.29792 h 71.67653 l -23.07865,46.51007 23.07865,65.47534 h 23.07798 L 230.1467,237.68577 207.06805,188.0146 v -0.37258 L 229.111,58.394295 296.13136,47.897159 V 14.23591 L 239.07012,0 H 207.06805 89.061925 Z")

    const labelBack = svg.append("text")
      .attr("x", 10+296+10+296/2)
      .attr("y", 80)
      .attr("font-size", "40px")
      .attr("text-anchor", "middle")
      .attr("fill", colors["900"])
      .text("Dos")

    bodyFace.on("click", function() {
      var coords = d3.mouse(this);
      bodyFaceGroup.append("circle")
        .attr("cx", coords[0])
        .attr("cy", coords[1])
        .attr("r", 5)
        .attr("fill", "white")
    })

    bodyBack.on("click", function() {
      var coords = d3.mouse(this);
      bodyBackGroup.append("circle")
        .attr("cx", coords[0])
        .attr("cy", coords[1])
        .attr("r", 5)
        .attr("fill", "white")
    })

    return null
  }

  render() {
    return (
      <div className="page">
        <div className="bodyhistory-tools">
          Let's put the drawing tools here!
        </div>
        <div className="bodyhistory-graph" ref={this.initChart.bind(this)}></div>
      </div>
    );
  }
}

export default BodyHistoryPage;
