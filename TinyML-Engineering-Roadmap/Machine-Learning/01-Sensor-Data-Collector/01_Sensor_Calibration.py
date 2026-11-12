import numpy as np
import matplotlib.pyplot as plt

def generate_sensor_dataset(n_samples=1000, noise_std=0.8, seed=42):
    """
    Simulates physical sensor acquisition data for calibration.

    Parameters:
    - n_sample: Number of data points to collect
    - noise_std: Standard deviation of the sensor measurement noise
    - seed: Random seed for reproducibility

    Returns:
    - x_raw: Uncalibrated sensor measurements (e.g., raw ADC counts / uncompensated values)
    - y_ref: Ground truth reference measurements (e.g., high-precision lab instruments)
    """
    np.random.seed(seed)

    # 1. Ground truth reference values spanning the operational range (e.g., 0°C to 100°C)
    y_ref = np.linspace(0, 100, n_samples)

    # 2. True physical parameters of the simulated imperfect sensor hardware
    true_gain = 1.05        # 5% sensitivity distortion
    true_offset = 3.2       # 3.2 unit voltage bias offset

    # 3. Generate raw measurements incorporating physical distortion and Gaussian noise
    # Formula: raw = (ref - offset) / gain + noise
    measurement_noise = np.random.normal(0, noise_std, n_samples)
    x_raw = (y_ref - true_offset) / true_gain + measurement_noise

    return x_raw, y_ref

# Task 1 Execution
if __name__ == "__main__":
    X_raw, Y_ref = generate_sensor_dataset(n_samples=1000)

    print(f"Successfully generated {len(X_raw)} sensor data points.")
    print(f"Raw Sensor Min/Max:    {X_raw.min():.2f} / {X_raw.max():.2f}")
    print(f"Reference Min/Max:     {Y_ref.min():.2f} / {Y_ref.max():.2f}")
    print(f"First 5 Raw Readings:  {np.round(X_raw[:5], 2)}")
    print(f"First 5 Ref Values:    {np.round(Y_ref[:5], 2)}")
