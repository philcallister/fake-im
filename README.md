# Fake IM
[![Build Status](https://travis-ci.org/philcallister/fake-im.svg?branch=master)](https://travis-ci.org/philcallister/fake-im)
[![Code Climate](https://codeclimate.com/github/philcallister/fake-im/badges/gpa.svg)](https://codeclimate.com/github/philcallister/fake-im)

This example, by [Phil Callister](http://github.com/philcallister), is an example client/server application that demonstrates a Ruby
Instant Messenger. It makes no attempt to follow standards, such as XMPP.

## Environment

The sample was developed using the following 

- JRuby 1.7.19
- OS X Yosemite (10.10.1)

## Setup

Clone Repo
```bash
git clone https://github.com/philcallister/fake-im.git
```

Gem Installation

```bash
gem install bundler
bundle install --binstubs .bundle/bin --path .bundle/gems
```

## Testing

Run the tests
```bash
rake test
```

## Run It

Start the server

```bash
./bin/fake_im_server
```

Start a telnet client

```bash
telnet localhost 10408
help
login:phil
group:subscribe:group1
```

Start another telnet client

```bash
telnet localhost 10408
login:amy
user:phil:HELLO
group:subscribe:group1
```

One more telnet client

```bash
telnet localhost 10408
login:nick
group:subscribe:group1
group:group1:HELLO GROUP1!!
```

## License

[MIT License](http://www.opensource.org/licenses/MIT)

**Free Software, Hell Yeah!**
