import numpy as np
import tensorflow as tf
import matplotlib.pyplot as plt
import math
from keras import layers

# 1. Generate Synthetic Sine Data with Noise

# Set seeds for reproducibility
SEED = 1337
np.random.seed(SEED)
tf.random.set_seed(SEED)

# Generate 1000 sample data points covering a full sine wave
SAMPLES = 1000
x_values = np.random.uniform(low=0.0, high=2 * math.pi, size=SAMPLES)

# Shuffle the values to ensure they are in random order for training
np.random.shuffle(x_values)

# Calculate the corresponding sine values and add random noise to simulate real-world sensors
y_values = np.sin(x_values)
y_values += 0.1 * np.random.randn(*y_values.shape)

# Plot the noisy data
plt.plot(x_values, y_values, 'b.')
plt.title("Noisy Sine Wave Data")
plt.show()

# 2. Split the data

# Reserve 60% of data for training and 20% for validation; the remaining 20% is for testing
TRAIN_SPLIT = int(0.6 * SAMPLES)
TEST_SPLIT = int(0.2 * SAMPLES + TRAIN_SPLIT)

# Split arrays into train, validation, and test sets at the calculated index boundaries
x_train, x_validate, x_test = np.split(x_values, [TRAIN_SPLIT, TEST_SPLIT])
y_train, y_validate, y_test = np.split(y_values, [TRAIN_SPLIT, TEST_SPLIT])

# Verify that no data points were lost or miscalculated during the split
assert (x_train.size + x_validate.size + x_test.size) == SAMPLES

# 3. Build a simple sequential neural network

model_1 = tf.keras.Sequential([
    layers.Dense(16, activation='relu', input_shape=(1,)),  # Hidden layer
    layers.Dense(1)                                         # Output layer
])

# Compile model with optimizer, loss function, and metrics
model_1.compile(optimizer='rmsprop', loss='mse', metrics=['mae'])

# Print model architecture summary
model_1.summary()

# Generate predictions from Model 1 and plot against actual training data
predictions_1 = model_1.predict(x_train)

plt.clf()
plt.title("Training Data Predicted vs Actual Values (Model 1)")
plt.plot(x_test, y_test, 'b.', label='Actual')
plt.plot(x_train, predictions_1, 'r.', label='Predicted')
plt.legend()
plt.show()

# 4. Build a larger model with an extra hidden layer for higher capacity

model_2 = tf.keras.Sequential([
    layers.Dense(16, activation='relu', input_shape=(1,)),  # First hidden layer
    layers.Dense(16, activation='relu'),                    # Second hidden layer
    layers.Dense(1)                                         # Output layer
])

# Compile using a modern Adam optimizer with an explicit learning rate
model_2.compile(
    optimizer=tf.keras.optimizers.Adam(learning_rate=0.01),
    loss='mse',
    metrics=['mae']
)

# Print the summary of the deeper network architecture
model_2.summary()

# 5. Train the model, validating performance and tracking history across epochs
history_2 = model_2.fit(
    x_train, y_train,
    epochs=600,
    batch_size=16,
    validation_data=(x_validate, y_validate)
)

# 6. Inspecting Loss and MAE Graphs (Skipping Early Epochs)
SKIP = 100
loss = history_2.history['loss']
val_loss = history_2.history['val_loss']
epochs = range(1, len(loss) + 1)

plt.plot(epochs[SKIP:], loss[SKIP:], 'g.', label='Training Loss')
plt.plot(epochs[SKIP:], val_loss[SKIP:], 'b.', label='Validation Loss')
plt.title("Training and Validation Loss (Zoomed)")
plt.xlabel('Epochs')
plt.ylabel('Loss')
plt.legend()
plt.show()

# 7. Converting the Model for TensorFlow Lite and Interpreter Evaluation Loop

# Convert to basic TFLite format
converter = tf.lite.TFLiteConverter.from_keras_model(model_2)
tflite_model = converter.convert()
with open("sine_model.tflite", "wb") as f:
    f.write(tflite_model)

# Convert with default optimizations and full integer quantization
converter_q = tf.lite.TFLiteConverter.from_keras_model(model_2)
converter_q.optimizations = [tf.lite.Optimize.DEFAULT]

def representative_dataset_generator():
    for value in x_test:
        yield [np.array(value, dtype=np.float32, ndmin=2)]

converter_q.representative_dataset = representative_dataset_generator
converter_q.target_spec.supported_ops = [tf.lite.OpsSet.TFLITE_BUILTINS_INT8]
converter_q.inference_input_type = tf.int8
converter_q.inference_output_type = tf.int8

tflite_quantized_model = converter_q.convert()
with open("sine_model_quantized.tflite", "wb") as f:
    f.write(tflite_quantized_model)

print(f"Basic TFLite size: {len(tflite_model)} bytes | Quantized size: {len(tflite_quantized_model)} bytes")
