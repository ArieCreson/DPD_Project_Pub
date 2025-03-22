import math
import pandas
import os
import matplotlib.pyplot as plt
import numpy as np
"""
Usage: Run the script and it will generate a csv file with the coefficients of the polynomials up to the degree specified in the function call.
First Run: python -i main	.py
then Run coefficents_csv(10) for example to generate a csv file with orthogonal polynomials coefficents up to degree 10.
"""

def coefficients_of_polynomial(order: int):
    """
        Generates a list of coefficents for a Volttera orthogonal polynomial of degree "order"
    """
    list_of_coefficients = []
    for i in range(1,order+1):
        coefficient = 1
        coefficient *= (-1)**(i+order)
        coefficient *= math.factorial(order+i) / (math.factorial(i-1) * math.factorial(i+1)*math.factorial(order-i))
        integer_value = int(coefficient)
        list_of_coefficients.append(integer_value)
    return list_of_coefficients

def return_table(order: int):
    table = []
    for i in range(1, order + 1):
        coefficients = coefficients_of_polynomial(i)
        table.append(f"Degree {i}: " + " + ".join(f"{c}|x|^{i-1}x" for i, c in enumerate(coefficients)))
    return table
def generate_table_of_polynomials(order: int):
    phi_k = []
    for i in range (1,order+1):
        coefficients = coefficients_of_polynomial(i)
        phi_k.append(coefficients)
    return phi_k


def coefficents_csv(order: int):
    list = generate_table_of_polynomials(order)
    if os.path.exists(f"coefficents_up_to_degree_{order}.csv"):
        return
    pd = pandas.DataFrame(list)
    pd = pd.astype(str)
    pd.to_csv(f"coefficents_up_to_degree_{order}.csv")
    print(f"coefficents_up_to_degree_{order}.csv has been created")

if __name__ == "__main__":
    value = None
    while type(value) != int:
        value = input("Enter the degree of the polynomial: ")
        value = int(value)
    coefficents_csv(value)




