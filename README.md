# resp.cr

![CI](https://github.com/Green-Edge/resp.cr/workflows/CI/badge.svg)

Lightweight [RESP](https://redis.io/topics/protocol) server and parser
written in Crystal. It can be used to implement a [Redisclone][redis]
or a Redis load balancer, for exemple.

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  resp:
    github: Green-Edge/resp.cr
```

## Usage

```crystal
require "resp"
server = RESP::Server.new
server.listen do |conn|
  # Returns the command followed by a list of arguments
  operation, args = conn.parse
  puts "operation: #{operation}, args: #{args}"
end
```

## Contributing

1. Fork it ( https://github.com/Green-Edge/resp.cr/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [hugoabonizio](https://github.com/hugoabonizio) Hugo Abonizio - original creator
- [Green-Edge](https://github.com/Green-Edge) Various Developers, including:
  - [OldhamMade](https://github.com/OldhamMade) Phillip Oldham

[redis]: https://github.com/hugoabonizio/resp.cr/blob/master/examples/redis_clone.cr
