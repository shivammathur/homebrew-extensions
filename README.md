# shivammathur/homebrew-extensions

<a href="https://github.com/shivammathur/homebrew-extensions" title="Homebrew tap for PHP extensions"><img alt="Build status" src="https://github.com/shivammathur/homebrew-extensions/workflows/Build%20Formulae/badge.svg"></a>
<a href="https://github.com/shivammathur/homebrew-extensions" title="Homebrew tap for PHP extensions"><img alt="Build status" src="https://github.com/shivammathur/homebrew-extensions/workflows/Test%20Formulae/badge.svg"></a>
<a href="https://github.com/shivammathur/homebrew-extensions/blob/master/LICENSE" title="license"><img alt="LICENSE" src="https://img.shields.io/badge/license-MIT-428f7e.svg"></a>
<a href="https://github.com/shivammathur/homebrew-extensions/tree/master/Formula" title="Formulae"><img alt="PHP Versions Supported" src="https://img.shields.io/badge/php-%3E%3D%205.6-8892BF.svg"></a>

> Homebrew tap for PHP extensions.

## Extensions

|Extension|PHP Version|
|--- |--- |
|`amqp`|`PHP 5.6` to `PHP 8.1`|
|`grpc`|`PHP 5.6` to `PHP 8.1`|
|`igbinary`|`PHP 5.6` to `PHP 8.1`|
|`imagick`|`PHP 5.6` to `PHP 8.1`|
|`imap`|`PHP 5.6` to `PHP 8.1`|
|`pcov`|`PHP 7.1` to `PHP 8.1`|
|`pecl_http`|`PHP 5.6` to `PHP 8.1`|
|`propro`|`PHP 5.6` to `PHP 7.4`|
|`protobuf`|`PHP 5.6` to `PHP 8.1`|
|`raphf`|`PHP 5.6` to `PHP 8.1`|
|`swoole`|`PHP 5.6` to `PHP 8.1`|
|`xdebug`|`PHP 5.6` to `PHP 8.1`|
|`xdebug2`|`PHP 7.2` to `PHP 7.4`|
|`zmq`|`PHP 5.6` to `PHP 8.1`|

## Usage

### Prerequisites

- Update homebrew and the formulae:

```zsh
brew update
```

- Check that the required PHP version is installed. This tap works with PHP from both `shivammathur/php` tap and `homebrew/core` tap.

```zsh
php -v
```
- If not, install the required PHP version, For example to install `PHP 7.4`.

```zsh
brew tap shivammathur/php
brew install php@7.4
brew link --force --overwrite php@7.4
```

Refer to [shivammathur/tap](https://github.com/shivammathur/homebrew-php) for more information about installing PHP.

### Install Extensions

- Add Tap `shivammathur/extensions`
```zsh
brew tap shivammathur/extensions
```

- Then install the required extension. See [Formula](Formula) directory for available formulae.

- For example, to install `Xdebug` on `PHP 7.4`.

```zsh
brew install xdebug@7.4
```

### Upgrade extensions

- For example, to upgrade `Xdebug` on `PHP 7.4`.

```zsh
brew upgrade xdebug@7.4
```

## License

The code in this project is licensed under the [MIT license](http://choosealicense.com/licenses/mit/).
Please see the [license file](LICENSE) for more information. This project has multiple [dependencies](#dependencies "Dependencies for this Homebrew tap"). Their licenses can be found in their respective repositories.

## Dependencies

- [amqp](https://github.com/php-amqp/php-amqp "amqp Upstream")
- [gRPC](https://github.com/grpc/grpc "gRPC Upstream")
- [igbinary](https://github.com/igbinary/igbinary "igbinary upstream")
- [Imagick](https://github.com/Imagick/imagick "Imagick upstream")
- [PECL-HTTP](https://github.com/m6w6/ext-http.git "PECL-HTTP Upstream")
- [PCOV](https://github.com/krakjoe/pcov "PCOV Upstream")
- [PHP Source](https://github.com/php/php-src "PHP Source")
- [Propro](https://github.com/m6w6/ext-propro "Propro Upstream")
- [Protobuf](https://github.com/protocolbuffers/protobuf "protocolbuffers Upstream")
- [Raphf](https://github.com/m6w6/ext-raphf "Raphf Upstream")
- [Swoole](https://github.com/swoole/swoole-src "Swoole Upstream")
- [Xdebug](https://github.com/xdebug/xdebug "Xdebug Upstream")
- [zmq](https://github.com/zeromq/php-zmq "ZMQ Upstream")
