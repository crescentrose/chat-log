# Chat Logs

This is a small chat log parser for TF2, ostensibly built as a stopgap solution.
It processes logs streamed to the log server through UDP, indexes them and
performs certain automatic moderation tasks such as reporting messages with
potentially malicious content.

## Usage

Run the provided `docker-compose.yml` file. This will set up the database,
Redis, job runner and the Rails app itself. You can customize your setup by
copying the `.env.example` file to `.env` and editing the settings inside.

**Important:** Docker mangles the source IP and port of an incoming UDP packet,
which this app relies on to match the message to the appropriate server
(unmatched messages will be silently dropped to prevent DoS attacks). You can
run `sudo conntrack -D -p udp` after your deploy and after the game server has
had a chance to send an UDP packet to your log server host to flush the
connection tracking cache and restore functionality.

Alternatively, set up the project yourself:

* set up Ruby 3.0+ (I suggest [rbenv](https://github.com/rbenv/rbenv)) and Node
  (any version will do)
* set up PostgreSQL 11+ and Redis
* `bundle` to get your gems in
* `bin/rails db:setup` to set up your database
* Dane's your uncle!

## License

```
Copyright 2022 Ivan Oštrić <ivan@halcyon.hr>

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```

## Acknowledgments

This project contains code extracted and modified from the [Steam
Condenser](https://github.com/koraktor/steam-condenser-ruby) project.
