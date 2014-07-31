#Reezy

This is a cheap clone of [Keezy](keezy.co). I figured I'd learned enough iOS basics to throw together something with similar functionality using a collection
view, gesture recognizers, audio recording & playback. Clone it & run it
to see what's up.

I'm still a beginner at this stuff so any advice is appreciated.

Things I'm not confident about:
* Holding audio recorders/players in memory vs. instantiating them when
  needed & discarding them immediately after
  * Decided I'd keep audio players in memory because they're better off
    snappy and there will only be 8 of them
  * Decided to create & discard audio recorders as necessary because
    they're only used once each
* Should probably make more files/classes to handle different sets of
  methods (the main view controller is pretty fat)

Things Keezy has that this doesn't (at least for now):
* Cool animation when you record audio for a cell
* That black circle in the middle that you swipe at to get to a
  main menu
* A 'main menu' at all, especially not with cool animations & UI
  elements
* The ability to save sets, load old sets, etc.
* The ability to undo
