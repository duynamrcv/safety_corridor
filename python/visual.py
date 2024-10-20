import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from matplotlib.patches import Polygon

# Load points
point_file = "data/points.csv"
df = pd.read_csv(point_file, sep=',')
df = np.array(df)

x = df[:,0]
y = df[:,1]

# Load corridor
point_file = "data/corridor.csv"
df = pd.read_csv(point_file, sep=',')
df = np.array(df)
cx = np.concatenate([df[:,0], [df[0,0]]])
cy = np.concatenate([df[:,1], [df[0,1]]])

fig = plt.figure()
ax = fig.subplots()
plt.scatter(x, y, label="Points")
plt.plot(cx, cy, label="Corridor")
plt.show()