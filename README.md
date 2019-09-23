# homebrew-stoic-public
Homebrew tap for stoic public formulae

## How do I use it ?
`brew install sutoiku/stoic-public/<formula>`

Or `brew tap sutoiku/stoic-public` and then `sutoiku/stoic-public/<formula>`.

## How do I contribute ?

### create a bottle

 - required : aws cli
 - update version number of formula.rb (local version is in `/usr/local/Homebrew/Library/Taps/sutoiku/homebrew-stoic-public/Formula/`)
```
cd /tmp
brew install --build-bottle sutoiku/stoic-public/<formula>
brew bottle sutoiku/stoic-public/<formula>
aws s3 cp ./<formula>-<version>.mojave.bottle.1.tar.gz s3://homebrew.stoic.com/<formula>-<version>.mojave.bottle.tar.gz # without '.1'
```
 - update formula with bottle infos

### references
 - https://github.com/Homebrew/brew/blob/master/docs/How-to-Create-and-Maintain-a-Tap.md
 - https://github.com/Homebrew/homebrew-tex
 - https://github.com/Homebrew/brew/blob/master/docs/Formula-Cookbook.md
 - https://github.com/Homebrew/brew/blob/master/docs/Bottles.md
