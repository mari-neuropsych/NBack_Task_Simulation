# N-back Task Simulation in Python (2-back & 3-back)
# Author: Mariam
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import random
import string
import time

# Settings
n_trials = 60
n_back_levels = [2, 3]
target_prob = 0.25
letters_set = list(string.ascii_uppercase)
level_colors = ['#0072BD', '#D95319']  # blue, orange

# Initialize results
all_results = []
performance_summary = []

# Loop over N-back levels
for idx, n_back in enumerate(n_back_levels):
    # Generate random letters
    letters = [random.choice(letters_set) for _ in range(n_trials)]
    is_target = [False]*n_trials

    for t in range(n_back, n_trials):
        if random.random() < target_prob:
            letters[t] = letters[t-n_back]
            is_target[t] = True

    # Simulate responses (for demo, we randomly decide correct/wrong)
    responses = []
    rt = []

    print(f"\n--- {n_back}-back Task ---")
    for t in range(n_trials):
        print(f"Trial {t+1}/{n_trials}: {letters[t]}")
        start_time = time.time()
        # Simulate user input (here randomly correct/wrong)
        if is_target[t]:
            response = np.random.choice([1, 0], p=[0.8, 0.2])  # 80% chance correct
        else:
            response = np.random.choice([0, 1], p=[0.8, 0.2])
        responses.append(response)
        rt.append(time.time() - start_time)
        time.sleep(0.05)  # short pause to simulate response time

    # Compute performance
    accuracy = np.mean([r == i for r, i in zip(responses, is_target)]) * 100
    mean_rt = np.mean(rt)
    print(f"{n_back}-back Results: Accuracy = {accuracy:.2f}%, Mean RT = {mean_rt:.3f} sec")

    # Save results
    df = pd.DataFrame({
        'NBack': [n_back]*n_trials,
        'Trial': np.arange(1, n_trials+1),
        'Stimulus': letters,
        'IsTarget': is_target,
        'Response': responses,
        'RT': rt
    })
    all_results.append(df)
    performance_summary.append({'NBack': n_back, 'Accuracy': accuracy, 'MeanRT': mean_rt})

# Combine all results and save CSV
results_df = pd.concat(all_results, ignore_index=True)
results_df.to_csv('NBack_Simulated_Results.csv', index=False)
print("\nAll data saved to NBack_Simulated_Results.csv")

# Plot performance summary
summary_df = pd.DataFrame(performance_summary)

fig, axs = plt.subplots(1, 2, figsize=(12,5))

# Accuracy plot
axs[0].bar(summary_df['NBack'], summary_df['Accuracy'], color=level_colors)
axs[0].set_xlabel('N-back Level')
axs[0].set_ylabel('Accuracy (%)')
axs[0].set_title('Accuracy per N-back Level')
axs[0].set_ylim([0,100])

# Mean RT plot
axs[1].bar(summary_df['NBack'], summary_df['MeanRT'], color=level_colors)
axs[1].set_xlabel('N-back Level')
axs[1].set_ylabel('Mean Reaction Time (s)')
axs[1].set_title('Mean Reaction Time per N-back Level')

plt.tight_layout()
plt.savefig('Performance_Summary_Colored.png')
plt.show()
print("Colored performance summary figure saved as Performance_Summary_Colored.png")
