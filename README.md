# InOrOut

The aim of this gem is to help automate the process of finding out whether your favorite AFL players are playing on this week.

This is hopefully useful for anyone involved in fantasy football, or if you simply want to know where they will be on a Saturday arvo.

The data for this app is based on the AFL's team lineups

## Installation

Add this line to your application's Gemfile:

    gem 'in_or_out'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install in_or_out

## Usage

Hopefully you find the gem easy to use:

Simple usage:

    require 'in_or_out'

    # They are considered in if they are listed on the field or on the interchange

    InOrOut::Player.new('Jobe Watson', 'Essendon').status
    => 'In'

    InOrOut::Player.new('Jobe Watson', 'Essendon').position
    => 'Centre'

    # They are considered out if they are not found on the list

    InOrOut::Player.new('Tim Watson', 'Essendon').status
    => 'Out'

    # They are 'possible' they are are an Emergency part of an unfinilised Interchange

    InOrOut::Player.new('Joe Daniher', 'Essendon').status
    => 'Possible'

    InOrOut::Player.new('Joe Daniher', 'Essendon').position
    => 'Interchange/Emergency'

    # They are 'unknown' if the teams are not released

    InOrOut::Player.new('Joe Daniher', 'Essendon').status
    => 'Unknown'

Advanced usage:

    # Get all your teams players in one go

    InOrOut::Team.new('Essendon')
    => []


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
