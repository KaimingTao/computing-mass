import wave
import struct
import math
import os

# Morse code dictionary
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

# Sound parameters
SAMPLE_RATE = 44100
DOT_DURATION = 0.1  # seconds
DASH_DURATION = DOT_DURATION * 3
FREQ = 800  # Hz
VOLUME = 0.5

def generate_tone(duration):
    num_samples = int(SAMPLE_RATE * duration)
    tone = [
        VOLUME * math.sin(2 * math.pi * FREQ * t / SAMPLE_RATE)
        for t in range(num_samples)
    ]
    return tone

def silence(duration):
    return [0.0] * int(SAMPLE_RATE * duration)

def text_to_morse(text):
    return ' '.join(MORSE_CODE.get(c, '') for c in text.upper() if c in MORSE_CODE)

def encode_morse_to_wave(morse_code):
    audio = []
    for char in morse_code:
        if char == '.':
            audio += generate_tone(DOT_DURATION) + silence(DOT_DURATION)
        elif char == '-':
            audio += generate_tone(DASH_DURATION) + silence(DOT_DURATION)
        elif char == ' ':
            audio += silence(DOT_DURATION * 3)
    return audio

def save_wave(filename, audio):
    with wave.open(filename, 'w') as wf:
        wf.setnchannels(1)
        wf.setsampwidth(2)
        wf.setframerate(SAMPLE_RATE)
        for sample in audio:
            value = int(sample * 32767.0)
            data = struct.pack('<h', value)
            wf.writeframesraw(data)

if __name__ == '__main__':
    message = input("Enter your message: ")
    morse = text_to_morse(message)
    print("Morse Code:", morse)
    audio = encode_morse_to_wave(morse)
    save_wave('morse_output.wav', audio)
    print("Saved morse_output.wav")
