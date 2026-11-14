import numpy as np
import matplotlib.pyplot as plt
from sensor_calibration_01 import generate_sensor_dataset

def explore_and_visualize_data(x_raw, y_ref):
    # 1. Statistical Exploration
    correlation = np.corrcoef(x_raw, y_ref)[0, 1]
    print(f"--- Dataset Statistical Summary ---")
    print(f"Pearson Correlation Coefficient (r): {correlation:.4f}")
    print(f"Raw Sensor Mean: {np.mean(x_raw):.2f} | Std Dev: {np.std(x_raw):.2f}")
    print(f"Reference Mean:  {np.mean(y_ref):.2f} | Std Dev: {np.std(y_ref):.2f}")

    # 2. Visualization Setup
    fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(14, 6))

    # Plot A: Raw Sensor vs Reference Line
    ax1.scatter(x_raw, y_ref, alpha=0.5, color='royalblue', edgecolors='none', label='Simulated Sensor Data')
    # Ideal theoretical response line for comparison
    ideal_x = np.linspace(x_raw.min(), x_raw.max(), 100)
    ax1.plot(ideal_x, 1.05 * ideal_x + 3.2, color='crimson', linestyle='--', linewidth=2, label='True Physical Response')

    ax1.set_title('Task 2A: Sensor Characterization Curve')
    ax1.set_xlabel('Raw Sensor Measurements (ADC / Uncalibrated)')
    ax1.set_ylabel('Reference Measurement (Ground Truth)')
    ax1.legend(loc='upper left')
    ax1.grid(True, linestyle=':', alpha=0.6)

    # Plot B: Noise / Error Distribution (Difference from ideal)
    ideal_y_expected = 1.05 * x_raw + 3.2
    measurement_errors = y_ref - ideal_y_expected

    ax2.hist(measurement_errors, bins=30, color='forestgreen', edgecolor='black', alpha=0.7)
    ax2.set_title('Task 2B: Sensor Measurement Noise Distribution')
    ax2.set_xlabel('Error Magnitude (Reference - Expected)')
    ax2.set_ylabel('Frequency')
    ax2.grid(True, linestyle=':', alpha=0.6)

    plt.tight_layout()
    plt.savefig('sensor_exploration.png', dpi=300)
    print("Visualization saved successfully as 'sensor_exploration.png'.")
    plt.show()

if __name__ == "__main__":
    X_raw, Y_ref = generate_sensor_dataset()
    explore_and_visualize_data(X_raw, Y_ref)
    
