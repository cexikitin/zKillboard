[![Scrutinizer Quality Score](https://scrutinizer-ci.com/g/EVE-KILL/zKillboard/badges/quality-score.png?s=b2d7078f70f6d3bd691e47db89eb455ec4c6002b)](https://scrutinizer-ci.com/g/EVE-KILL/zKillboard/)

# zKillboard
zKillboard is a killboard created for EVE-Online, for use on EVE-KILL.net, but can also be used for single entities.

## Credits
zKillboard is released under the GNU Affero General Public License, version 3. The full license is available in the `AGPL.md` file.
zKillboard also uses data and images from EVE-Online, which is covered by a seperate license from [CCP](http://www.ccpgames.com/en/home). You can see the full license in the `CCP.md` file.
It also uses various 3rd party libraries, which all carry their own licensing. Please refer to them for more info.

## WARNING
This is BETA, which means it is a work in progress.  It lacks documentation and is currently
not meant for use in production.

## Contact
`#esc` on `irc.coldfront.net`
Mibbit link incase you're lazy: http://chat.mibbit.com/?channel=%23esc&server=irc.coldfront.net

## LICENSE
see `LICENSE.md` file

# Running zKillboard

## Dependencies
- PHP 5.4+ / HHVM 2.4+
- Apache + mod_rewrite, Nginx or Lighttpd
- Linux, Mac OS X or Windows
- MariaDB 5.5+
- Composer
- cURL and it's php library, php5-curl

## Path
Always use the /public/ dir in your httpd, many things are located in said directory that are needed for the page to work.

## Nginx Config
```
upstream php-upstream {
  server unix:/tmp/php-fpm.sock;
  server 127.0.0.1:9000;
}

server {
  server_name example.com www.example.com;
  listen      80;
  root        /path/to/zkb_install/public;

  location    / {
    try_files $uri $uri/ /index.php?$args;
  }

  location    ~ \.php$ {
    try_files $uri =404;
    include   fastcgi_params;
    fastcgi_index index.php;
    fastcgi_pass  php-upstream;
  }
}

```

## Apache rewrite
Apache rewrite is handled by the .htaccess, located in the /public directory.

## Apache Config
```
<VirtualHost *:80>
        ServerAlias yourdomain.tld

        DocumentRoot /path/to/zkb_install/public/
        <Directory /path/to/zkb_install/public/>
          Require all granted
          Options FollowSymLinks MultiViews
          AllowOverride All
          Order allow,deny
          Allow from all
        </Directory>
</VirtualHost>
```

## Lighttpd config (Including redirect/rewrite rules)
```
url.redirect = (
  "/?a=kill_detail&kll_id=([0-9]+)" => "/evekilldetailintercept/$1/",
  "/?a=kill_related&kll_id=([0-9]+)" => "/evekillrelatedintercept/$1/"
)

url.rewrite-if-not-file = (
  "(.*)" => "/index.php/$0"
)
server.document-root = "/path/to/zkb_install/public/"
```

## Other webservers
Other webservers are supported, aslong as they can run PHP, they should work.
But other webservers have other ways to write rewrites, so from our side of things, they are unsupported.
Feel free to issue pull requests to amend this.

## Recommended
- PHP 5.5+ / HHVM 2.4+
- Linux
- MariaDB 5.5+
- Composer
- APC / Memcached / Redis
- cURL and it's php plugin, php5-curl

## Installation
Installation is handled via command line. Other methods are currently not supported.

1. `cd` to a dir where you want zKillboard to reside.
2. Do `git clone git@github.com:EVE-KILL/zKillboard.git`.
3. `cd` into `zKillboard` dir.
4. Get composer. `curl -s https://getcomposer.org/installer | php`
5. Install vendor files with composer. `php composer.phar install`
6. `cd` into `install` dir.
7. Execute the installation script. `php5 install.php`
8. Follow the instructions and fill in the prompts
9. Setup stomp (Follow guide further down)
10. Setup the CLI system.
11. Setup cronjobs

## CLI System
1. Symlink cli.php to /usr/bin/zkillboard `ln -s /path/to/zkb/cli.php /usr/bin/zkillboard`
2. Install bash-completion. Under Debian this can be done like so `apt-get install bash-completion`
3. Move `bash_complete_zkillboard` to `/etc/bash_completion.d/zkillboard`
4. Restart your shell session
5. Issue `zkillboard list` and enjoy the zkillboard cli interface, with full tab completion

## Cronjobs
zKillboard comes with a script that automates the cron execution.
It keeps track of when each job has been run and how frequently it needs to be executed.
Just run it every minute via cron or a similar system:

```
* * * * * /var/killboard/zkillboard.com/cron.php >/whatever/log/you/like.txt 2>&1
```

If you're not happy with the default timeouts, or want to disable/enable some jobs entirely, you can use the cron.overrides file.
The cron.overrides file has to be placed into the zKB root dir, next to the cron.php script. It's a simple json file, with the following format:

```json
{
    "commandName":{
        "timeoutInSeconds":"arguments"
    }
}
```

For example the following would disable stompReceive entirely, and increase the timeout for apiFetch and parseKills to 5 minutes:
```json
{
    "stompReceive":{},
    "apiFetch":{
        "300":""
    },
    "parseKills":{
        "300":""
    }
}
```

All cronjobs can be launched manually with the cli interface.

## Stomp
Stomp uses the STOMP PHP plugin which you can get via git.
Here is a quick one liner: `cd /tmp/ && git clone https://github.com/php/pecl-tools-stomp.git && cd pecl-tools-stomp && phpize && ./configure && make && make install`
After that you make a `20-stomp.ini` in `/etc/php5/conf.d/` and add `extension=stomp.so` to it, and save. And restart your php stuff.

The stomp service is read only. If you need to send data via it, come by IRC and have a chat with us.

- Stomp server: tcp://stomp.zkillboard.com:61613
- Stomp user: guest
- Stomp pass: guest

## HHVM
zKillboard runs perfectly under hhvm, which provides a near 10x speed increase aswell.

To get HHVM look at https://github.com/facebook/hhvm/wiki#installing-pre-built-packages-for-hhvm

### HHVM Config
```
Server {
  Type = fastcgi
  #Port = 9000
  #IP = 127.0.0.1
  FileSocket = /run/shm/hhvm.sock

  APC {
    EnableApc = true
    TableType = concurrent
    ExpireOnSets = true
    PurgeFrequency = 4096
  }
}

Eval {
  Jit = true
  JitWarmupRequests = 50
}

Log {
  Level = Error
  NoSlencer = true
  AlwaysLogUnhandledExceptions = true
  RuntimeErrorReportingLevel = 8191
  UseLogFile = true
  UseSyslog = false
  InjectedStackTrace = true
  NativeStackTrace = true
  File = /var/log/hhvm/error.log
  Access {
    * {
      File = /var/log/hhvm/access.log
      Format = %h %l %u % t \"%r\" %>s %b
    }
  }
}

ErrorHandling {
  CallUserHandlerOnFatals = true
  MaxLoopCount = 0
  NoInfiniteRecursionDetection = false
  ThrowBadTypeExceptions = false
  ThrowTooManyArguments = false
  WarnTooManyArguments = false
  ThrowMissingArguments = false
  ThrowInvalidArguments = false
  EnableHipHopErrors = true
  NoticeFrequency = 1    # 1 out of these many notices to log
  WarningFrequency = 1   # 1 out of these many warnings to log
  AssertActive = false
  AssertWarning = false
}

 Debug {
  FullBacktrace = true
  ServerStackTrace = true
  ServerErrorMessage = true
  TranslateSource = true

  RecordInput = false
  ClearInputOnSuccess = true

  ProfilerOutputDir = /tmp
  CoreDumpEmail = email address
  CoreDumpReport = true
  CoreDumpReportDirectory = /tmp
}

Repo {
  Central {
    Path = /var/log/hhvm/.hhvm.hhbc
  }
}

MySQL {
  ReadOnly = false
  ConnectTimeout = 1000 # in ms
  ReadTimeout = 2000 # in ms
  SlowQueryThreshold = 4000 # in ms
  KillOnTimeout = true
  WaitTimeout = -1
  TypedResults = true
}
```

## Admin account

Every clean zKillboard installation now comes with an admin account, default password admin, it it highly recommended that you immediately change this password after you finish your installation.

Current special features to the admin account:

1) Any entities (pilots, corporations, etc.) added to the Admin's tracker will automatically be fetched from https://zkillboard.com up to and including a full fetch of all kills and maintaining a fetch of said kills on an hourly basis.  Of course, this is dependent on proper cronjob setup.


