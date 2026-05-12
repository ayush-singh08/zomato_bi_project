import pandas as pd

df = pd.read_csv("zomato.csv")

# Drop problematic columns
df.drop(
    ['reviews_list', 'menu_item'],
    axis=1,
    inplace=True
)

# Save cleaned file
df.to_csv("zomato_clean.csv", index=False)