import pygame
import sys
from pygame.locals import *

pygame.init()
screen = pygame.display.set_mode((400, 300))
pygame.display.set_caption('Key Press Time Tracker')

# Track key press durations
key_press_times = {}

clock = pygame.time.Clock()

while True:
    for event in pygame.event.get():
        if event.type == QUIT:
            pygame.quit()
            sys.exit()

        if event.type == KEYDOWN:
            if event.key not in key_press_times:
                # Record the time when the key is pressed down
                key_press_times[event.key] = pygame.time.get_ticks()

        if event.type == KEYUP:
            if event.key in key_press_times:
                # Calculate duration the key was pressed
                press_duration = pygame.time.get_ticks() - key_press_times[event.key]
                print(f"Key '{pygame.key.name(event.key)}' pressed for {press_duration} milliseconds.")

                # Remove the key from the tracking dictionary
                del key_press_times[event.key]

    # Fill the screen with black
    screen.fill((0, 0, 0))

    pygame.display.flip()
    clock.tick(60)


    print(key_press_times)
