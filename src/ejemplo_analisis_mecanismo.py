from sympy import symbols, Eq, cos, sin, Matrix
from sympy.physics.mechanics import dynamicsymbols
import numpy as np
import matplotlib.pyplot as plt

# Ejemplo muy simple: trayectoria de un punto acoplado a una manivela (radio R).
R, theta = symbols('R theta')
t = np.linspace(0, 2*np.pi, 400)
Rval = 1.0
x = Rval*np.cos(t)
y = Rval*np.sin(t)

plt.plot(x, y)
plt.gca().set_aspect('equal', adjustable='box')
plt.title('Trayectoria de un punto en una manivela (R=1)')
plt.xlabel('x [m]'); plt.ylabel('y [m]')
plt.show()