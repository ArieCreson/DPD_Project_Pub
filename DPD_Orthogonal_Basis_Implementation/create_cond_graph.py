import generate_csv_file


import numpy as np
import matplotlib.pyplot as plt


def phi_k(x,k):
    coef_list =generate_csv_file.coefficients_of_polynomial(k)
    sum = 0 
    for i,j in enumerate(coef_list):
        sum += j*x*abs(x)**(i)
    return sum
def create_mat_rand(vec,k):
    coef_list =generate_csv_file.coefficients_of_polynomial(k)
    temp = []
    for i,j in enumerate(coef_list):
        temp1 = [phi_k(j,i+1) for j in vec]
        temp.append(temp1)
    return temp
def calc_cond_num_of_vec(vec):
    return np.linalg.cond(np.matmul(vec,np.transpose(vec)))
def uniform(size):
    return np.random.uniform(low = 0.0, high = 1.0, size = size)
def truncate(func):
    x = func()
    while not 0<=x<=1:
        x = func()
    return x
def rayleigh_trunc(size,sigma):
    l = lambda: np.random.rayleigh(scale=sigma, size=1)[0]
    temp = [truncate(l) for _ in range(size)]
    return temp

def gaussian_trunc(size,sigma,cent):
    l = lambda: np.random.normal(loc= cent,scale=sigma)
    temp = [truncate(l) for _ in range(size)]
    return temp

rand1 = uniform(1000000)
rand2 = rayleigh_trunc(1000000,0.29)
rand3 = gaussian_trunc(1000000,1,0.5)
data = []

for vec in [rand1,rand2,rand3]:
    temp = []
    for i in range(1,11):
        x = create_mat_rand(vec,i)
        y = calc_cond_num_of_vec(x)
        temp.append(y)
    data.append(temp)
