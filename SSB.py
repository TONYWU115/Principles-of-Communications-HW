import numpy as np
import matplotlib.pyplot as plt
from scipy.signal import hilbert

# Parameter settings
f1 = 10  # Assume f1 is 10 Hz
fs = 1000 # Sampling frequency, at least twice the highest frequency, set high enough for detail
t = np.linspace(0, 1, fs, endpoint=False) # Time axis, 1 second of data

# Message signal m(t)
m_t = np.cos(2 * np.pi * f1 * t) - 0.4 * np.cos(4 * np.pi * f1 * t) + 0.9 * np.cos(6 * np.pi * f1 * t)

# Hilbert transform
m_t_hilbert = hilbert(m_t)

# Assume carrier frequency fc (should be higher than the highest frequency of the message signal)
fc = 100
carrier = np.cos(2 * np.pi * fc * t)

# Upper Sideband SSB signal (USB-SSB)
usb_ssb = m_t * np.cos(2 * np.pi * fc * t) - np.imag(m_t_hilbert) * np.sin(2 * np.pi * fc * t)

# Lower Sideband SSB signal (LSB-SSB)
lsb_ssb = m_t * np.cos(2 * np.pi * fc * t) + np.imag(m_t_hilbert) * np.sin(2 * np.pi * fc * t)

# Envelope of SSB signal (demonstrated with USB-SSB, LSB-SSB envelope is the same)
envelope_ssb = np.abs(m_t + 1j * np.imag(m_t_hilbert))

# Plotting
plt.figure(figsize=(12, 10))

plt.subplot(5, 1, 1)
plt.plot(t, m_t)
plt.title('Message Signal m(t)')
plt.xlabel('Time (s)')
plt.ylabel('Amplitude')
plt.grid(True)

plt.subplot(5, 1, 2)
plt.plot(t, np.imag(m_t_hilbert))
plt.title('Hilbert Transform of Message Signal')
plt.xlabel('Time (s)')
plt.ylabel('Amplitude')
plt.grid(True)

plt.subplot(5, 1, 3)
plt.plot(t, envelope_ssb)
plt.title('Envelope of SSB Signal')
plt.xlabel('Time (s)')
plt.ylabel('Amplitude')
plt.grid(True)

plt.subplot(5, 1, 4)
plt.plot(t, usb_ssb)
plt.title('Upper Sideband SSB Signal')
plt.xlabel('Time (s)')
plt.ylabel('Amplitude')
plt.grid(True)

plt.subplot(5, 1, 5)
plt.plot(t, lsb_ssb)
plt.title('Lower Sideband SSB Signal')
plt.xlabel('Time (s)')
plt.ylabel('Amplitude')
plt.grid(True)

plt.tight_layout()
plt.show()