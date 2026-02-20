# Python KPI Utility Script
# Example: Data Cleaning + KPI Calculation

import pandas as pd

def load_data(path):
    return pd.read_csv(path)

def calculate_conversion_rate(df, numerator_col, denominator_col):
    df["conversion_rate"] = df[numerator_col] / df[denominator_col]
    return df

def summary(df):
    return df.describe()

if __name__ == "__main__":
    print("Python KPI Utility Ready")
