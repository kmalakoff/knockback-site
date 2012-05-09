````
    __ __                  __   __               __       _
   / //_/____  ____  _____/ /__/ /_  ____ ______/ /__    (_)____
  / ,<  / __ \/ __ \/ ___/ //_/ __ \/ __ `/ ___/ //_/   / / ___/
 / /| |/ / / / /_/ / /__/ ,< / /_/ / /_/ / /__/ ,< _   / (__  )
/_/ |_/_/ /_/\____/\___/_/|_/_.___/\__,_/\___/_/|_(_)_/ /____/
                                                   /___/
````

Knockback.js provides Knockout.js magic for Backbone.js Models and Collections.

### Website: http://kmalakoff.github.com/knockback/

You can get the library here:

* [Development version][1]
* [Production version][2]

[1]: https://github.com/kmalakoff/knockback/raw/master/knockback.js
[2]: https://github.com/kmalakoff/knockback/raw/master/knockback.min.js

You can find Knockout [here][3], Backbone.js [here][4], and Underscore.js [here][5].

[3]: https://github.com/SteveSanderson/knockout/downloads/
[4]: http://documentcloud.github.com/backbone/
[5]: http://documentcloud.github.com/underscore/

Building the web site
-----------------------

Installing:

1. install ruby: http://www.ruby-lang.org
2. install bundler: http://gembundler.com
3. install gems: (sudo) 'bundle install'
4. install node.js: http://nodejs.org
5. install node packages: (sudo) 'npm install'

Commands:

1. 'rake clean' - cleans the project of all compiled files
2. 'rake build' - performs a single build
3. 'rake watch' - automatically scans for and builds the project when changes are detected
4. 'rake package' - cleans the project of all compiled files and builds
