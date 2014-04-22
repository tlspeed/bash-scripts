#!/bin/bash

## Bad Cows are not appropriate for all audiences.  Use at own risk
badCows=(bong head-in kiss sodomized sodomized-sheep telebears)

## Cow files to use
cows=(apt beavis.zen bud-frogs bunny cheese cower daemon default dragon dragon-and-cow elephant elephant-in-snake eyes flaming-sheep ghostbusters hellokitty kitty koala kosh luke-koala mech-and-cow meow milk moofasa moose mutilated ren satanic sheep skeleton small stegosaurus stimpy supermilker surgery three-eyes turkey turtle tux udder vader vader-koala www)

## Moods for the displays (see man cowfile)
moodOpts=(-g -p -s -t -w -y)

#Generate random  numbers
random=RANDOM%43
moodRandom=RANDOM%6

cowfile=${cows[random]}
mood=${moodOpts[moodRandom]}

echo "CowFile ${cowfile}  Mood $mood"
fortune | cowsay -f ${cowfile} ${mood}
