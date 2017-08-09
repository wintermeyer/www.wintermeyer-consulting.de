# Wintermeyer Consulting Homepage

For the static part of my business homepage https://www.wintermeyer-consulting.de I use Jekyll.
Main reasons:

- A static page is hard to break.
- WebPerformance

More information about Jekyll: http://jekyllrb.com

## Developement

Git clone the repository. Run bundle and fire up the
development version with `bundle exec jekyll serve`

## Dirty Hacks

I haven't had time to come up with a proper way to do this. So until I do I have to do the following commands when ever I change sass files in _sass:

- `cd _sass`
- `sass milligram.sass > ../_includes/css/milligram.css`
