# GDD - Magnum Opus The Quest.
v0.1

**A Game By:**
* mrmav @ https://mrmav.itch.io/
* serrot @  https://luistorres.itch.io/

# Introduction 
- [GDD - Magnum Opus The Quest.](#gdd---magnum-opus-the-quest)
- [Introduction](#introduction)
	- [Game Summary Pitch](#game-summary-pitch)
	- [Inspiration](#inspiration)
	- [Player Experience](#player-experience)
	- [Platform](#platform)
	- [Development Software](#development-software)
	- [Genre](#genre)
	- [Target Audience](#target-audience)
- [Concept](#concept)
	- [Gameplay overview](#gameplay-overview)
	- [Theme Interpretation(s)](#theme-interpretations)
		- [Connection](#connection)
		- [Alchemy](#alchemy)
		- [Shadows](#shadows)
		- [Other Limitations](#other-limitations)
	- [Primary Mechanics](#primary-mechanics)
		- [Selecting nodes](#selecting-nodes)
		- [Creating a recipe \& getting result](#creating-a-recipe--getting-result)
		- [Leaving the path shadow](#leaving-the-path-shadow)
	- [Secondary Mechanics](#secondary-mechanics)
		- [Special ingredients \& processes](#special-ingredients--processes)
		- [Special recipes](#special-recipes)
- [Art](#art)
- [Audio](#audio)
- [UX](#ux)
	- [User Interface](#user-interface)
	- [Control](#control)
- [Development](#development)
	- [MVP](#mvp)
	- [Goodies \& Extras](#goodies--extras)

## Game Summary Pitch
Fill the role of a desperate alchemist wiling to do anything to get to the [[philosophers stone]]. 
Chooses between ingredients that only in the thoughts of a desperate soul would make any sense.
Once you fail, fear not, since you are not alone. Just like you there are others chasing the recipe. 
Fail and leave your shadow behind, so others may succeed.

## Inspiration
* "Potion Craft (beta)" with is themes of searching and adventure
* "Path of Exile" with its immense skill tree game
* "Dark Souls" messages
* "Journey" with its the interaction with strangers

## Player Experience
Players fill the role of the higly regarded alchemist [Insert name here].
Between a maze of ingredients and processes players can choose the alchemy path to their concoction, hopefully the highly regarded [[philosophers stone]].
After selecting ingredients, players can try to Transmutate them into a philosophers stone. After, mostly likely failing given the immense amount of options, 
the player will get a result of how close he was to the concoction, percent based. Now the player is given the option to color their path in:
* **Nigredo**: Facing and purging inner darkness. (for bad paths)
* **Albedo**: Achieving purification and spiritual clarity. (for better ones)
* **Citrinitas**: Gaining wisdom and deeper understanding. (almost there)
* **Rubedo**: Reaching unity and enlightenment. (to hopefully mark the successful attempts in acquiring the concoction.)
* 
Players are however not mandated to use the color properly, and can interfere with the main community goal of achieving the best recipe.
Score is based on how efficient the path is, meaning that the are multiple way to make the stone, some better then others.

## Platform
WebGL & Mobile

## Development Software
* Godot 3.6rc1
* Kenney Assets
* Node.js
* Audacity
* Paint.net
* VSCode
* Github
* Git
  
## Genre
Multiplayer Player, puzzle, casual, clicker, social

## Target Audience
Casual players who are looking for a social challenge where they in will cooperative (or not) with strangers looking for a common but competitive objective eternal youth or something.

# Concept
## Gameplay overview
The player interacts with a node interface with a multitude of ingredients and processes, with the objective of, by trial and error, find the most perfect recipe.
Every failure allows the player to leave a colored shadow so that other players may not fail in the same way, or even achieve the same recipe if successful.
Other than the usual ingredients a alchemist would use there are also processes, like boiling and fermenting that can, or not, be part of the recipe.
There are processes and ingredients that do not affect the recipe, leaving space for imperfect recipes that will result in a sub-part score.

Hint: the recipe is in the neurons

## Theme Interpretation(s)
For a more challenging experience (obviously a very good idea), this game was made for **two** game jams, 
Bellow follows the themes Interpretations & the correspondent jam

### Connection
* [KenneyJam2024 https://itch.io/jam/kenney-jam-2024]
  
The player must navigate a maze of connections between elements, natural or not. This navigation is a overwhelming web of interface nodes.

### Alchemy
* [Pirate Software - Game Jam 15 https://itch.io/jam/pirate]
  
Players are challenged into discovering the recipe to the [[philosophers stone]]. (quite on the nose)

### Shadows
* [Pirate Software - Game Jam 15 https://itch.io/jam/pirate]
  
Each run leaves it's shadow that can be seen by other players, (this shadow can have a custom color chosen by its maker). 

### Other Limitations
* Kenney Assets for the Kenney jam
* Single Button (this one was easy)
* Co-op (or maybe not)

## Primary Mechanics
### Selecting nodes
Player can select ingredients(nodes) by navigating the graph and clicking or taping.
### Creating a recipe & getting result
Players can merge any of the selected ingredients, and get feedback for how close their where to the recipe, or if lucky and the recipe is correct, how perfect it is.
### Leaving the path shadow
After getting their result players can chose to tint their choices, making it so that the path chosen gets more colored in one the the four options.

## Secondary Mechanics
### Special ingredients & processes
Ingredients and Processes with special interactions like:
* Run-Killer process: Tasting the concoction would certainly end in death. 
* Hint ingredients: let you peak forward int the next node and see if their are part of the recipe.

### Special recipes
Some recipe instead of just resulting in a lose screen, unlock special achievements like:
* Hamburger!
* Soup!
  

# Art
WIP
The art will consist of modified ui elements and 2d sprites from Kenney. (Thanks Kenney)
Below follow how and which sprites and assets are used for what:

| Asset                       | Solution                                  |
| --------------------------- | ----------------------------------------- |
| Philosophers Stone          | 3D/TowerDefenseKit/detail_crystal         |
| Philosophers Stone Particle | 2D/JumperPack/particle_pink               |
| Background                  | 2D/CartographyPack/Papers                 |
| Base Elements               | 2d/Planets                                |
| Outer Elements              | 2D/InterfacePack/minimapMap_blank         |
| The Squared Circle          | 2D/PatternPack2/Thin Edited merged shapes |
| Selection Particles         | 2D/VoxelPack/Particles/swirl_white        |
| Ribbitonious                | 2D/Animal                                 |
| Hat                         | 2D/ScribblePlatformer                     |
| Banner                      | 2D/InterfacePack/bannerScroll             |


# Audio
WIP

# UX
The overall player UX should be streamlined and quick. 
Given the limited mechanics, the main player hook is going to be exploration and novelty. The visuals and animation will do most of this heavy lifting.

## User Interface 
The whole game is player in a single screen. Without transitions that is.
Player have the option to:
*  see the leaderboard and what the score of the top recipes.
*  play the game
*  disable music (or other basic setting)
*  exit

When playing the player has the option to:
* select ingredients, (cannot deselect, by design)
* submit recipe
* or go back to menu

After submitting the player has the option to:
* Retry
* Select a color to tint the run (and then retry)
	* **Nigredo**: Facing and purging inner darkness.
    * **Albedo**: Achieving purification and spiritual clarity.
	* **Citrinitas**: Gaining wisdom and deeper understanding.
    * **Rubedo**: Reaching unity and enlightenment.
* Leave a name(maybe)

## Control
* Mouse
	* Right Click - Primary Action
	* Left Click -- Secondary Action
* Touch Screen
	* Tap --------- Primary Action
	* Hold -------- Secondary Action
  
# Development
Below follows the rough dev plan.

## MVP
| Feature                   | Importance 1-5 | Budget (hh) | Status |
| ------------------------- | :------------: | :---------: | :----: |
| Node interface            |       5        |      4      |  DONE  |
| Previous attempt Paths    |       5        |      4      |  DONE  |
| Colored Path              |       3        |      2      |  DONE  |
| Win Condition             |       5        |      2      |  DONE  |
| Lose Condition            |       5        |      2      |  DONE  |
| Multiplayer Previous Runs |       5        |      8      |  DONE  |
| Score Menu                |       3        |      2      |  DONE  |
| Multiplayer LeaderBoard   |       3        |      2      |  WIP   |
| Win Menu                  |       3        |      2      |   -    |
| Better Ingredient Tree    |       5        |      4      |   -    |
| Better Ingredient Tree    |       3        |      2      |   -    |


  
## Goodies & Extras
| Feature                                  | Importance 1-5 | Budget (hh) | Status |
| ---------------------------------------- | :------------: | :---------: | :----: |
| Settings Menu                            |       1        |      4      |   -    |
| Colorblind support                       |       2        |      2      |   -    |
| Daily recipe (A* Pathfinding generated?) |       2        |      2      |   -    |
| Daily Leader Board                       |       2        |      2      |   -    |
| All Time Leader Board                    |       2        |      2      |   -    |
| Special Recipes                          |       2        |      2      |   -    |
| Special Ingredients and processes        |       2        |      2      |   -    |
