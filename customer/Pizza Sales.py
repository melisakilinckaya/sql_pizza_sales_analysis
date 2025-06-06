# Gerekli olan kütüphaneleri import etmektedir
import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt

# Veri setini okutmaktadır sonraında veri setini incelemektedir
df = pd.read_csv(r'C:\Users\Melisa\PycharmProjects\PythonProject3\customer\Enhanced_pizza_sell_data_2024-25 Dosyasının Kopyası.csv', sep=';')
df.head()
df.shape
df.info()
df.describe()
df.columns

# Pizza boyutlarının (orta, buyuk, kucuk) dagılımını 'Pie Chart' kullanarak görsellestirmektedir.
size_counts = df['Pizza Size'].value_counts()
plt.figure(figsize=(8,6))
plt.pie(size_counts, labels=size_counts.index,autopct='%1.1f%%', startangle=140,colors=plt.cm.Paired.colors)
plt.title('Pizza Boyutu Dagılımı', fontsize=20)
plt.axis('equal')
plt.show()

# Pizza turlerını 'Bar Chart' kullanaral görsellestirmektedir.
type_counts = df['Pizza Type'].value_counts()
plt.figure(figsize=(8,6))
type_counts.plot(kind='bar', color='skyblue')
plt.title('Pizza Turu Dagılımı', fontsize=20)
plt.xlabel('Pizza Turu')
plt.ylabel('Satıs Adedi')
plt.xticks(rotation=30)
plt.show()

# Pizza turu ve pizza boyutlarının satıslarını bir arada analiz etmek icin 'Pivot Table',
# analizin sonuclarını görsellestirmek icin ise 'Heatmap' olusturur.
pivot_table = pd.crosstab(df['Pizza Type'], df['Pizza Size'])
pivot_table
plt.figure(figsize=(10,6))
sns.heatmap(pivot_table, annot=False, fmt='d', cmap='YlGnBu')
plt.title('Pizza Turu ve Boyutuna Gore Satıs Dagılımı')
plt.xlabel('Pizza Boyutu')
plt.ylabel('Pizza Turu')
plt.show()

