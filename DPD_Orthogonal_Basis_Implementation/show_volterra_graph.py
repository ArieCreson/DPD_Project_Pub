import generate_csv_file
import math
import pandas
import os
import matplotlib.pyplot as plt
import numpy as np
from generate_csv_file import coefficients_of_polynomial, generate_table_of_polynomials

"""
-Requirements:
	pip3 install numpy
	pip3 install matplotlib
 	pip3 install pandas
"""


def create_volttera_plot(order: int):
	"""
	Description: Generates a plot of the polynomials up to the order specified.
	Usage: python
	:param order (int):
	shows a plot of the polynomial coefficients
	"""
	coefficients = generate_table_of_polynomials(order)
	x = np.linspace(0, 1, 1000)
	for i in range(order):
		y = sum(c * (np.abs(x) ** i)*x for i, c in enumerate(coefficients[i]))
		plt.plot(x, y, label=f"Degree {i+1}")
	plt.legend()
	plt.show()

def create_plot_normal(order: int):
	"""
	Usage: python3 -i main2.py
	       create_plot_normal(4)
	:param order:
	:return:
	"""
	coefficients = list(list())
	for i in range(order):
		coefficients.append([1]*(i+1))
	x = np.linspace(0, 1, 1000)
	for i in range(order):
		y = sum(c * (np.abs(x) ** i) * x for i, c in enumerate(coefficients[i]))
		plt.plot(x, y, label=f"Degree {i + 1}")
	plt.legend()
	plt.show()
