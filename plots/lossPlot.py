import seaborn as sns
import pandas as pd
import matplotlib.pyplot as plt

df = pd.read_csv('data/loss.csv', decimal=',')
df['ack'] = df['ack'].astype(str)

#df.drop(df.index[df['ack'] == '0'], inplace=True)

plt.tight_layout()
plt.figure(figsize=(20,5))

df['ack'] = df['ack'].replace({'-2': 'Reliable Ack'})
df['ack'] = df['ack'].replace({'-1': 'Replicas Confirm.'})
df['ack'] = df['ack'].replace({'0': 'Fire and Forget'})
df['ack'] = df['ack'].replace({'1': 'Leader Confirm.'})

print(df) 

sns.set(style = 'white')

g = sns.barplot(x='vazao', y='chance', hue='ack', orient='h', data=df,
				errcolor='black', capsize=0.04, errwidth=2, saturation=8, ci="sd",
				edgecolor=".08", linewidth=0.02)
g.legend_.set_title(None)

plt.xlabel('Probabilidade de perder pacotes (%)')
plt.ylabel('Vazão (mensagens/seg)')

plt.savefig('./pdfs/loss-vazao-FF.pdf')
#plt.savefig('./pdfs/loss-vazao.pdf')
plt.clf()
