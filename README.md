#Reezy

This is a cheap clone of [Keezy](keezy.co). I figured I'd learned enough iOS basics to throw together something with similar functionality using a collection
view, gesture recognizers, audio recording & playback. The only part of
it that's actually better than the real Keezy is the colors. Keezy's color scheme looks like vomit.

Anyways, clone it & run this bad boy in XCode to see what's up.

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
* Still figuring out how to make cells respond to quick successive
  touches (if a second touch happens too fast, like double-tap speed,
  it's not registered). I want to fix this so rapid-fire sounds are
  possible. For now, just [slow down](https://www.youtube.com/watch?v=fJdqw-JzW08)

Things Keezy has that this doesn't (at least for now):
* Cool animation when you record audio for a cell
* That black circle in the middle that you swipe at to get to a
  main menu
* A 'main menu' at all, especially not with cool animations & UI
  elements
* The ability to save sets, load old sets, etc.
* The ability to undo

Obstacles I hit and tackled without confidence:
* I originally made only one UILongPressGestureRecognizer for the whole
  collectionView because I was under the impression that this was a good
  pattern to follow (you make the one gesture recognizer and use the touch location to determine which cell the user's interacting with).
  However, this only allowed for the playback of one cell's audio at a time. Playing audio from multiple cells simultaneously is a big part of why Keezy is so much fun, so I ditched the memory-efficient pattern and made separate gesture recognizers for each cell. If there's a better way to solve this issue, LET ME KNOW PLEASE.
