Install EWD3
============

Install Node.js
---------------

`Download Node.js installer<https://nodejs.org/en/download/>`_

Install EWD3 & EWD VistA On Linux With GT.M
-------------------------------------------

.. raw:: html
    
    <div class="code"><code>$ mkdir ewd3
    $ cd ewd3
    $ npm install ewd-xpress
    $ npm install nodem
    
    $ cp node_modules/ewd-session/mumps/ewdSymbolTable.m ~/r/
    $ cp node_modules/nodem/src/v4wNode.m ~/r/
    
    $ npm install ewd-xpress-monitor
    $ mkdir www
    $ mkdir www/ewd-xpress-monitor
    $ cp node_modules/ewd-xpress-monitor/www/* www/ewd-xpress-monitor/
    
    $ npm install ewd-vista
    $ npm install ewd-vista-login
    $ npm install ewd-vista-bedboard
    
    $ cp node_modules/ewd-vista/routines/ewdVistAFileman.m ~/r/
    $ cp node_modules/ewd-vista/routines/ewdVistARPC.m ~/r/
    
    $ cd node_modules/ewd-vista
    $ npm install -g browserify
    $ npm install babelify
    $ npm install bootstrap
    $ npm install jquery
    $ npm install jquery-ui
    $ npm install toastr
    
    $ cd node_modules/ewd-vista
    $ browserify -t [babelify] www/assets/javascripts/app.js -o www/assets/javascripts/bundle.js
    $ cd ../..
    $ mkdir www/ewd-vista
    $ cp -R node_modules/ewd-vista/www/* www/ewd-vista/
    $ cp -nR node_modules/ewd-vista-login/www/* www/ewd-vista/
    $ cp -nR node_modules/ewd-vista-bedboard/www/* www/ewd-vista/
    
    $ cp node_modules/ewd-xpress/example/ewd-xpress-gtm.js ./ewd-xpress.js
    $ node ewd-xpress.js</code></div>

Visit http://localhost:8080/ewd-vista/
