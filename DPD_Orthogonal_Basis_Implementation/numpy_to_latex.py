import numpy as np
import math
def float_to_fracstring(num:float,accuracy = 2) -> str:
    min = abs(num) - 0
    for i in range(1,10**accuracy):
        for j in range(1,10**accuracy):
            if abs(i/j) <= min:
                min = abs(i/j)
    return i,j


def matrix_to_latex(matrix, matrix_type='bmatrix'):
    """
    Converts a numpy matrix into a LaTeX string.

    Parameters:
    matrix (numpy.ndarray): The input matrix (2D).
    Returns:
    str: LaTeX formatted string for the matrix.
    """
    rows = []
    for row in matrix:
        row_str = " & ".join(map(str, row))  # Join each element in a row with "&"
        rows.append(row_str)

    # Join all rows with "\\"
    matrix_str = " \\\\ ".join(rows)

    # Construct the full LaTeX matrix code
    latex_code = f"\\begin{{{matrix_type}}}\n{matrix_str}\n\\end{{{matrix_type}}}"
    latex_code = "\\["+latex_code+"\\]"
    return latex_code


# Example usage
matrix = np.array([[1, 2], [3,4], [5,6]])
matrix_inverse = np.linalg.pinv(matrix)
latex_code = matrix_to_latex(matrix)
latex_code2 = matrix_to_latex(matrix_inverse)
matrix3 = matrix_inverse@matrix
print(matrix3)

print(latex_code,latex_code2)
