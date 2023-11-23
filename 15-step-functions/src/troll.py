import random

# step function that randomly decides if the troll will chase the hero
def troll_chase_handler(event, context):
    return {
        "decision": "chase" if random.randint(0, 1) == 1 else "ignore"
    }

def player_enter_cave_handler(event, context):
    return {
        "enter": "yes" if random.randint(0, 1) == 1 else "no"
    }