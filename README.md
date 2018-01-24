# homebrew-stoic-public
Homebrew tap for stoic public formulae

## How do I use it ?
`brew install sutoiku/stoic-public/<formula>`

Or `brew tap sutoiku/stoic-public` and then `sutoiku/stoic-public/<formula>`.

## How do I contribute ?

### create a bottle

 - required : aws cli
```
cd /tmp
brew install --build-bottle sutoiku/stoic-public/<formula>
brew bottle sutoiku/stoic-public/<formula>
aws s3 cp ./<formula>.high_sierra.bottle.1.tar.gz s3://homebrew.stoic.com
```
 - update formula with bottle infos

### references
 - https://github.com/Homebrew/brew/blob/master/docs/How-to-Create-and-Maintain-a-Tap.md
 - https://github.com/Homebrew/homebrew-tex
 - https://github.com/Homebrew/brew/blob/master/docs/Formula-Cookbook.md
 - https://github.com/Homebrew/brew/blob/master/docs/Bottles.md
