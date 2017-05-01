import * as React from 'react';
import * as _ from 'lodash';

interface IProps {
  str: string,
}

class Manacost extends React.Component<IProps, any> {
  static regex = new RegExp('\{[0-9A-Z]}\}')
  renderCosts() {
    if (!this.props.str) {
      return null;
    }

    const parts = this.props.str.split(Manacost.regex);

    return _.map(parts, part => <div className={`ManaIcon sprite-${part.charAt(1)}`} />);
  }

  render() {
    return <div>
      {this.renderCosts()}
    </div>;
  }
}

export default Manacost;
