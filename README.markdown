## Hardware Simulations in Ruby

This project started with a simple question:

Starting with *just a NAND gate*, how high can we move up the hardware stack?

The `/lib/gates/nand.rb` uses Ruby's logic operators. From there on up, everything relies on connections to NANDs.

What's the point of all this? I used to find hardware fascinating. In undergrad, I struggled to understand how these things were really put together. But part of that misunderstanding, especially when building hardware simulations, was due to my shallow knowledge of abstraction and automated testing.

Powered by Minitest and great Wikipedia references, here comes some hardware.
