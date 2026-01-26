import pyaudio
import math
import time

# Morse code mapping
MORSE_CODE = {
    'A': '.-',     'B': '-...',   'C': '-.-.',  'D': '-..',    'E': '.',
    'F': '..-.',   'G': '--.',    'H': '....',  'I': '..',     'J': '.---',
    'K': '-.-',    'L': '.-..',   'M': '--',    'N': '-.',     'O': '---',
    'P': '.--.',   'Q': '--.-',   'R': '.-.',   'S': '...',    'T': '-',
    'U': '..-',    'V': '...-',   'W': '.--',   'X': '-..-',   'Y': '-.--',
    'Z': '--..',
    '0': '-----',  '1': '.----',  '2': '..---', '3': '...--',  '4': '....-',
    '5': '.....',  '6': '-....',  '7': '--...', '8': '---..',  '9': '----.'
}

# Parameters
FREQ = 800           # tone frequency in Hz
SAMPLE_RATE = 44100  # samples per second
DOT_DURATION = 0.1   # seconds
VOLUME = 0.5         # 0.0 to 1.0

def generate_tone(duration):
    n_samples = int(SAMPLE_RATE * duration)
    return bytes([
        int(VOLUME * 127 * math.sin(2 * math.pi * FREQ * t / SAMPLE_RATE) + 128)
        for t in range(n_samples)
    ])

def play_tone(stream, duration):
    samples = generate_tone(duration)
    stream.write(samples)

def silence(stream, duration):
    stream.write(bytes([128] * int(SAMPLE_RATE * duration)))  # mid-level silence

def text_to_morse(text):
    return ' '.join(MORSE_CODE.get(c, '') for c in text.upper() if c in MORSE_CODE)

def play_morse(text):
    morse = text_to_morse(text)
    print("Morse Code:", morse)

    p = pyaudio.PyAudio()
    stream = p.open(format=pyaudio.paUInt8, channels=1, rate=SAMPLE_RATE, output=True)

    try:
        for symbol in morse:
            if symbol == '.':
                play_tone(stream, DOT_DURATION)
                silence(stream, DOT_DURATION)
            elif symbol == '-':
                play_tone(stream, DOT_DURATION * 3)
                silence(stream, DOT_DURATION)
            elif symbol == ' ':
                silence(stream, DOT_DURATION * 3)
    finally:
        stream.stop_stream()
        stream.close()
        p.terminate()

if __name__ == '__main__':
    msg = input("Enter a message: ")
    play_morse(msg)
