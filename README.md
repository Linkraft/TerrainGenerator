# TerrainGenerator
Terrain generator program that utilizes [random walk](https://en.wikipedia.org/wiki/Random_walk) functionality.  The UI scales with monitor window size and features options that allow the user to customize the size, shape, frequency, density, and spacing of terrain tiles, as well as the number of tiles to generate and the speed at which the generation executes. It utilizes Processing, a Java-based language, and was created by me for my Introduction to Digital Arts and Sciences class at the University of Florida.

## Dependencies
- [Processing 3.4](https://processing.org/reference/)
- [ControlP5 library](http://www.sojamo.de/libraries/controlP5/)

## Usage
To start, navigate in the Processing program UI to Sketch -> Import Library -> Add Library, then search for ControlP5 and install it. Then start the program by opening up any of the files and pressing the Run button in the top left. You can customize the program's resolution by modifying the first statement in the `void setup()` function at the top of the Project2 file. Make sure that your desired resolution is some multiple of (1200, 1000), e.g. (600, 500) or (1800, 1500), or else the UI will look a little wonky.

As far as program settings during runtime, the slider and button options are pretty self explanatory once you start messing with their values. The only setting that requires explanation is the `Use Random Seed` option, along with the `SeedValue` input box. In order to enter a seed value, you must type it in and then press *Enter*, then check the `Use Random Seed` option.

## Documentation
Information regarding the inner working of the program can be found in the `Project2.pdf` file.

## Timeframe
This project was completed back in the fall of 2018 and took around 8-12 hours to complete.
