import * as React from 'react';
import * as _ from 'lodash';
import { List, ListItem } from 'material-ui/List';

import Item from './card_list/item';

interface IProps {
  cards: Array<{ mtgio_id: string, name: string }>,
}

class CardList extends React.Component<IProps, any> {
  render() {
    return <List style={{ paddingTop: 0 }}>
      {_.map(this.props.cards, (card) => <Item key={card.mtgio_id} card={card} />)}
    </List>;
  }
}

export default CardList;