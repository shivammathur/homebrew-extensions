<p align="center">
  <a href="https://github.com/shivammathur/homebrew-extensions" target="_blank">
    <img src="https://repository-images.githubusercontent.com/272870557/ec55a100-a309-11eb-9d60-a922ed6bebd4" alt="Homebrew Tap for PHP extensions" width="560">
  </a>
</p>

<h1 align="center">brew tap shivammathur/extensions</h1>

<p align="center">
    <a href="https://github.com/shivammathur/homebrew-extensions" title="Homebrew tap for PHP extensions">
      <img alt="Build status" src="https://github.com/shivammathur/homebrew-extensions/workflows/Build%20Formulae/badge.svg">
    </a>
    <a href="https://github.com/shivammathur/homebrew-extensions" title="Homebrew tap for PHP extensions">
      <img alt="Build status" src="https://github.com/shivammathur/homebrew-extensions/workflows/Test%20Formulae/badge.svg">
    </a>
    <a href="https://github.com/shivammathur/homebrew-extensions/blob/master/LICENSE" title="license">
      <img alt="LICENSE" src="https://img.shields.io/badge/license-MIT-428f7e.svg?logo=open%20source%20initiative&logoColor=white&labelColor=555555">
    </a>
    <a href="https://github.com/shivammathur/homebrew-extensions/tree/master/Formula" title="Formulae for PHP extensions">
      <img alt="PHP Versions Supported" src="https://img.shields.io/badge/php-5.6%20to%208.2-777bb3.svg?logo=php&logoColor=white&labelColor=555555">
    </a>
    <a href="https://github.com/shivammathur/homebrew-extensions#os-support" title="Apple Intel x86_64 supported">
      <img alt="macOS architectures supported" src="https://img.shields.io/badge/macOS-Intel%20x86__64%20-007DC3?logo=apple&logoColor=555555&labelColor=ffffff">
    </a>  
    <a href="https://github.com/shivammathur/homebrew-extensions#os-support" title="Apple arm64 supported">
      <img alt="macOS architectures supported" src="https://img.shields.io/badge/macOS-Apple%20arm64%20-c0476d?logo=apple&logoColor=555555&labelColor=ffffff">
    </a>
</p>

## Extensions

|Extension|PHP Version|
|--- |---
|`amqp`|`PHP 5.6` to `PHP 8.2`
|`apcu`|`PHP 5.6` to `PHP 8.2`|
|`grpc`|`PHP 5.6` to `PHP 8.2`|
|`igbinary`|`PHP 5.6` to `PHP 8.2`|
|`imagick`|`PHP 5.6` to `PHP 8.2`|
|`imap`|`PHP 5.6` to `PHP 8.2`|
|`memcache`|`PHP 5.6` to `PHP 8.2`|
|`memcached`|`PHP 5.6` to `PHP 8.2`|
|`mongodb`|`PHP 5.6` to `PHP 8.2`|
|`msgpack`|`PHP 5.6` to `PHP 8.2`|
|`pcov`|`PHP 7.1` to `PHP 8.2`|
|`pecl_http`|`PHP 5.6` to `PHP 8.2`|
|`phalcon3`|`PHP 5.6` to `PHP 7.3`|
|`phalcon4`|`PHP 7.2` to `PHP 7.4`|
|`propro`|`PHP 5.6` to `PHP 7.4`|
|`protobuf`|`PHP 5.6` to `PHP 8.2`|
|`psr`|`PHP 5.6` to `PHP 8.2`|
|`raphf`|`PHP 5.6` to `PHP 8.2`|
|`rdkafka`|`PHP 5.6` to `PHP 8.2`|
|`redis`|`PHP 5.6` to `PHP 8.2`|
|`swoole`|`PHP 5.6` to `PHP 8.2`|
|`vips`|`PHP 7.0` to `PHP 8.2`|
|`xdebug`|`PHP 5.6` to `PHP 8.2`|
|`xdebug2`|`PHP 7.2` to `PHP 7.4`|
|`yaml`|`PHP 5.6` to `PHP 8.2`|
|`zmq`|`PHP 5.6` to `PHP 8.2`|

## OS Support

|Operating System|Architecture|
|--- |--- |
|Linux 4.18+|`x86_64`|
|macOS Catalina|`x86_64`|
|macOS Big Sur|`x86_64`, `arm64`|
|macOS Monterey|`x86_64`, `arm64`|

- On Linux, GLIBC 2.27 or newer is required, so distributions with Linux kernel 4.18 and newer are supported.
For example: Ubuntu 18.04, Debian 10, CentOS 8, Fedora 28, and newer versions of these distributions.

- All extensions except `imap` and `vips` are built on Linux.

## Usage

### Prerequisites

- Update homebrew and the formulae:

```zsh
brew update
```

- Check that the required PHP version is installed. This tap works with PHP from both `shivammathur/php` tap and `homebrew/core` tap:

```zsh
php -v
```
- If not, install the required PHP version, For example to install `PHP 7.4`:

```zsh
brew tap shivammathur/php
brew install shivammathur/php/php@7.4
brew link --force --overwrite php@7.4
```

Refer to [shivammathur/php](https://github.com/shivammathur/homebrew-php) tap for more information about installing PHP.

### Install PHP Extensions

- Add Tap `shivammathur/extensions`:

```zsh
brew tap shivammathur/extensions
```

- Then install the required extension. See [Formula](Formula) directory for available formulae.

- For example, to install `Xdebug` on `PHP 7.4`:

```zsh
brew install xdebug@7.4
```

### Upgrade extensions

- For example, to upgrade `Xdebug` on `PHP 7.4`.

```zsh
brew upgrade xdebug@7.4
```

## Debugging

- Make sure you ran `brew update` before installing PHP.

- Run `brew doctor` and fix the warnings it reports.

- Make sure homebrew has correct permissions.

```zsh
sudo chown -R "$(id -un)":"$(id -gn)" $(brew --prefix)
```

- Check if your issue is a Homebrew's [common issue](https://docs.brew.sh/Common-Issues).

- If you are still facing an issue, please create a discussion thread [here](https://github.com/shivammathur/homebrew-extensions/discussions).

## License

The code in this project is licensed under the [MIT license](http://choosealicense.com/licenses/mit/).
Please see the [license file](LICENSE) for more information. This project has multiple [dependencies](#dependencies "Dependencies for this Homebrew tap"). Their licenses can be found in their respective repositories.

## Contributions

Contributions are welcome!
Please see [Contributor's Guide](.github/CONTRIBUTING.md "shivammathur/homebrew-extensions contribution guide") before you start.
If you face any issues while using this tap or want to suggest a feature/improvement, create an discussion thread [here](https://github.com/shivammathur/homebrew-extensions/discussions "shivammathur/extensions discussions").

## Related Projects

- [shivammathur/homebrew-php](https://github.com/shivammathur/homebrew-extensions "Tap for PHP extensions")
- [shivammathur/setup-php](https://github.com/shivammathur/setup-php "Setup PHP in GitHub Actions")

## Dependencies

### Extensions

- [arnaud-lb/php-rdkafka](https://github.com/arnaud-lb/php-rdkafka "rdkafka")
- [grpc/grpc](https://github.com/grpc/grpc "gRPC")
- [igbinary/igbinary](https://github.com/igbinary/igbinary "igbinary")
- [Imagick/imagick](https://github.com/Imagick/imagick "Imagick")
- [jbboehr/php-psr](https://github.com/jbboehr/php-psr "Psr")
- [krakjoe/apcu](https://github.com/krakjoe/apcu "APCu")
- [krakjoe/pcov](https://github.com/krakjoe/pcov "PCOV")
- [libvips/php-vips-ext](https://github.com/libvips/php-vips-ext "Vips")
- [m6w6/ext-http](https://github.com/m6w6/ext-http.git "PECL-HTTP")
- [m6w6/ext-propro](https://github.com/m6w6/ext-propro "Propro")
- [m6w6/ext-raphf](https://github.com/m6w6/ext-raphf "Raphf")
- [mongodb/mongo-php-driver](https://github.com/mongodb/mongo-php-driver "Mongodb")
- [msgpack/msgpack](https://github.com/msgpack/msgpack-php "Msgpack")
- [phalcon/cphalcon](https://github.com/phalcon/cphalcon "Phalcon")
- [php-amqp/php-amqp](https://github.com/php-amqp/php-amqp "amqp")
- [php-memcached-dev/php-memcached](https://github.com/php-memcached-dev/php-memcached "Memcached")
- [php/pecl-file_formats-yaml](https://github.com/php/pecl-file_formats-yaml "PHP YAML")
- [php/php-src](https://github.com/php/php-src "PHP Source")
- [phpredis/phpredis](https://github.com/phpredis/phpredis "Redis")
- [protocolbuffers/protobuf](https://github.com/protocolbuffers/protobuf "protocolbuffers")
- [swoole/swoole-src](https://github.com/swoole/swoole-src "Swoole")
- [websupport-sk/pecl-memcache](https://github.com/websupport-sk/pecl-memcache "Memcache")
- [xdebug/xdebug](https://github.com/xdebug/xdebug "Xdebug")
- [zeromq/php-zmq](https://github.com/zeromq/php-zmq "ZMQ")

### Homebrew

- [homebrew/brew](https://github.com/Homebrew/brew "Homebrew/brew")
- [homebrew/actions](https://github.com/Homebrew/homebrew-actions "Homebrew/homebrew-actions")
- [homebrew/core](https://github.com/Homebrew/homebrew-core "Homebrew/homebrew-core")
- [homebrew/homebrew-test-bot](https://github.com/homebrew/homebrew-test-bot "homebrew/homebrew-test-bot")
- [shivammathur/php](https://github.com/shivammathur/homebrew-php "shivammathur/homebrew-php")

### Formulae dependencies

- [brotli](https://formulae.brew.sh/formula/brotli "brotli")
- [curl](https://formulae.brew.sh/formula/curl "curl")
- [czmq](https://formulae.brew.sh/formula/czmq "czmq")
- [grpc](https://formulae.brew.sh/formula/grpc "grpc")
- [icu4c](https://formulae.brew.sh/formula/icu4c "icu4c")
- [imagemagick](https://formulae.brew.sh/formula/imagemagick "imagemagick")
- [imap-uw](https://formulae.brew.sh/formula/imap-uw "imap")
- [krb5](https://formulae.brew.sh/formula/krb5 "krb5")
- [libevent](https://formulae.brew.sh/formula/libevent "libevent")
- [libidn2](https://formulae.brew.sh/formula/libidn2 "libidn2")
- [liblzf](https://formulae.brew.sh/formula/liblzf "liblzf")
- [libmemcached](https://formulae.brew.sh/formula/libmemcached "libmemcached")
- [librdkafka](https://formulae.brew.sh/formula/librdkafka "librdkafka")
- [libyaml](https://formulae.brew.sh/formula/libyaml "libyaml")
- [lz4](https://formulae.brew.sh/formula/lz4 "lz4")
- [openssl](https://formulae.brew.sh/formula/openssl@1.1 "openssl")
- [pcre](https://formulae.brew.sh/formula/pcre "pcre")
- [rabbitmq-c](https://formulae.brew.sh/formula/rabbitmq-c "rabbitmq")
- [snappy](https://formulae.brew.sh/formula/snappy "snappy")
- [vips](https://formulae.brew.sh/formula/vips "vips")
- [zeromq](https://formulae.brew.sh/formula/zeromq "zeromq")
- [zstd](https://formulae.brew.sh/formula/zstd "zstd")
