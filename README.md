# Chat Logs

This is a small chat log parser for TF2, ostensibly built as a stopgap solution.
It will take in a log file uploaded from an associated server, optionally
secured by a secret token, and spin off a background job to parse it and save
the chat messages.

## Usage

Run the provided `docker-compose.yml` file. This will set up the database,
Redis, job runner and the Rails app itself. You can customize your setup by
copying the `.env.example` file to `.env` and editing the settings inside.

Alternatively, set up the project yourself:

* set up Ruby 3.0+ (I suggest [rbenv](https://github.com/rbenv/rbenv)) and Node
    14+
* set up PostgreSQL 11+
* `bundle` to get your gems in
* `yarn` to get your frontend packages in
* `bin/rails db:setup` to set up your database
* Dane's your uncle!

There's a `support/uploader.sh` script that you can use on the servers - it will
automatically keep track of the last uploaded log file and upload the ones that
were not uploaded yet. Run it through cron.

## License

```
Copyright 2021 Ivan Oštrić <ivan@halcyon.hr>

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
