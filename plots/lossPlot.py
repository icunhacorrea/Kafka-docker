import seaborn as sns
import pandas as pd
import matplotlib.pyplot as plt
import matplotlib.ticker as ticker

df = pd.read_csv('data/loss.csv', decimal=',')
df['ack'] = df['ack'].astype(str)

#df.drop(df.index[df['ack'] == '0'], inplace=True)

plt.tight_layout()
plt.figure(figsize=(50, 20))

df['ack'] = df['ack'].replace({'-2': 'Reliable Ack'})
df['ack'] = df['ack'].replace({'-1': 'Replicas Confirm.'})
df['ack'] = df['ack'].replace({'0': 'Fire and Forget'})
df['ack'] = df['ack'].replace({'1': 'Leader Confirm.'})

print(df) 

sns.set(style = 'ticks', font_scale=1.3)

hue_order = ['Fire and Forget', 'Reliable Ack', 'Leader Confirm.', 'Replicas Confirm.']

g = sns.barplot(x='vazao', y='chance', hue='ack', orient='h', data=df,
				errcolor='black', capsize=0.04, errwidth=2, saturation=8, ci="sd",
				edgecolor=".08", linewidth=0.04, hue_order=hue_order)
g.legend_.set_title(None)
g.xaxis.set_major_locator(ticker.MultipleLocator(1000))
#g.xaxis.set_major_locator(ticker.MultipleLocator(5000))
g.xaxis.set_major_formatter(ticker.ScalarFormatter())

plt.gcf().set_size_inches(15.7, 5.27)
plt.ylabel("% de perda de pacote")
plt.xlabel('Vazão (msg/seg)')
#plt.xlabel('Tempo de execução (seg)')

plt.savefig('./pdfs/loss-vazao-FF.pdf', bbox_inches='tight', dpi=600)
#plt.savefig('./pdfs/loss-tempo-FF.pdf', bbox_inches='tight', dpi=600)
plt.clf()
