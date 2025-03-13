import pandas as pd
import json

events_df = pd.read_csv('/Users/olivia/Documents/Data Analytics Project/Cafe+Rewards+Offers/events.csv')

events_df['offer_id'] = None
events_df['amount'] = None
events_df['reward'] = None

for idx, row in events_df.iterrows():
    try:
        value_dict = json.loads(row['value'].replace("'", '"'))

        if row['event'] in ['offer received', 'offer viewed']:
            events_df.at[idx, 'offer_id'] = value_dict.get('offer id')

        elif row['event'] == 'offer completed':
            events_df.at[idx, 'offer_id'] = value_dict.get('offer_id')
            events_df.at[idx, 'reward'] = value_dict.get('reward')

        elif row['event'] == 'transaction':
            events_df.at[idx, 'amount'] = value_dict.get('amount')
    except:
        pass

events_df = events_df.drop('value', axis=1)

events_df.to_csv('events_normalized.csv', index=False)
