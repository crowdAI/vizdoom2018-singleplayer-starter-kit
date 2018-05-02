#!/usr/bin/env python3

import vizdoom as vzd
from random import choice
import os

game = vzd.DoomGame()
game.load_config("config/custom_config.cfg")

# Name your agent
#
# Note: The grading infrastructure will provide the expected agent name
# in the environment variable `CROWDAI_AGENT_NAME`
# If your agent does not use this environment variable then the score
# will not be counted against your username.
if "CROWDAI_AGENT_NAME" in os.environ.keys():
    name = os.environ["CROWDAI_AGENT_NAME"]
else:
    name = "SampleRandomAgent"

# and select color
# colors: 0 - green, 1 - gray, 2 - brown, 3 - red, 4 - light gray, 5 - light brown, 6 - light red, 7 - light blue
color = 0
game.set_doom_scenario_path("mock.wad")
game.add_game_args("-join localhost +name {} +colorset {}".format(name, color))
game.set_console_enabled(True)
game.set_window_visible(False)

game.init()

# Three sample actions: turn left/right and shoot
actions = [[1, 0, 0], [0, 1, 0], [0, 0, 1]]

# Play until the game (episode) is over.
while not game.is_episode_finished():

    if game.is_player_dead():
        # Use this to respawn immediately after death, new state will be available.
        game.respawn_player()

        # Or observe the game until automatic respawn.
        # game.advance_action();
        # continue;

    # Analyze the state ... or not
    s = game.get_state()
    # print(s)

    # Make your action.
    game.make_action(choice(actions))

    # Log time and frags/kills every ~10 seconds
    if s.number % 350 == 0:
        print("Time: {}, Kills: {}, Frags: {}",
              game.get_episode_time(),
              game.get_game_variable(vzd.GameVariable.KILLCOUNT),
              game.get_game_variable(vzd.GameVariable.FRAGCOUNT))

print("Episode FINISHED !")
game.close()
