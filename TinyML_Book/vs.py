import numpy as np
import tensorflow as tf
import matplotlib.pyplot as plt
import math

# 1. Generate Synthetic Sine Data with Noise

# Set seed for reproducibility
SEED = 1337
np.random.seed(SEED)
tf.random.set_seed(SEED)

# Generate 1000 sample datapoints covering a full sine wave
SAMPLES = 1000
x_values = np.random.uniform(low=0.0, high=2 * math.pi, size=SAMPLES)

# Shuffle the values to ensure they are in random order for training
np.random.shuffle(x_values)

# Calculate the corresponding sine values and add random noise to simulate real-world sensors
y_values = np.sin(x_values)
y_values += 0.1 * np.random.randn(*y_values.shape)

# Plot the noisy dataset
plt.plot(x_values, y_values, 'b.')
plt.title("Noisy Sine Wave Data")
plt.show()

# 2. Splitting the Data
TRAIN_SPLIT = int(0.6 * SAMPLES)
TEST_SPLIT = int(0.2 * SAMPLES + TRAIN_SPLIT)

x_train, x_validate, x_test = np.split(x_values, [TRAIN_SPLIT, TEST_SPLIT])
y_train, y_validate, y_test = np.split(y_values, [TRAIN_SPLIT, TEST_SPLIT])

assert (x_train.size + x_validate.size + x_test.size) == SAMPLES
