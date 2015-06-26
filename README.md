vindictive-voter
===

> A CLI that upvotes or downvotes people on Reddit.

Usage
===
```
Usage: vindictive-voter [options] ...
    -v, --version                    Show the version
    -h, --help                       Show the usage
    -u, --upvote USER                Upvote a user (to be used in conjuction with -c or -p
    -d, --downvote USER              Downvote a user (to be used in conjunction with -c or -p
        --url URL                    Sets the specific url to rage against
        --delay DELAY                Sets the delay between clicking the up/down vote buttons
        --pages PAGES                Number of pages to go through
```

Install
===
```sh
$ git clone https://github.com/ddavison/vindictive-voter
$ cd bin
$ ./vindictive-voter --help
```

Examples
===

Upvote 2 pages worth of a users comments (total of 50 upvotes [25 per page])
```sh
./vindictive-voter -u my-user --url https://reddit.com/user/my-user/comments/ --pages 2
```

Downvote a users posts every 1 second
```sh
./vindictive-voter -d some-user --url https://www.reddit.com/user/some-user/submitted/
```

##NOTE
You will need to have `VINDICTIVE_USER` and `VINDICTIVE_PASS` environment variables set.

When running, you can simply do
```sh
VINDICTIVE_USER=my-bot-user VINDICTIVE_PASS=thepass ./vindictive-voter ...
```
