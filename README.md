# shivammathur/homebrew-extensions

<a href="https://github.com/shivammathur/homebrew-extensions" title="Homebrew tap for PHP extensions"><img alt="Build status" src="https://github.com/shivammathur/homebrew-extensions/workflows/Build%20Formulae/badge.svg"></a>
<a href="https://github.com/shivammathur/homebrew-extensions" title="Homebrew tap for PHP extensions"><img alt="Build status" src="https://github.com/shivammathur/homebrew-extensions/workflows/Test%20Formulae/badge.svg"></a>
<a href="https://github.com/shivammathur/homebrew-extensions/blob/master/LICENSE" title="license"><img alt="LICENSE" src="https://img.shields.io/badge/license-MIT-428f7e.svg"></a>
<a href="https://github.com/shivammathur/homebrew-extensions/tree/master/Formula" title="Formulae"><img alt="PHP Versions Supported" src="https://img.shields.io/badge/php-%3E%3D%205.6-8892BF.svg"></a>

> Homebrew tap for PHP extensions.

## Extensions

|Extension|PHP Version|
|--- |--- |
|`grpc`|`PHP 5.6` to `PHP 7.4`|
|`igbinary`|`PHP 5.6` to `PHP 8.1`|
|`imagick`|`PHP 5.6` to `PHP 8.0`|
|`imap`|`PHP 5.6` to `PHP 8.0`|
|`pcov`|`PHP 7.1` to `PHP 8.1`|
|`protobuf`|`PHP 5.6` to `PHP 7.4`|
|`swoole`|`PHP 5.6` to `PHP 7.4`|
|`xdebug`|`PHP 5.6` to `PHP 8.1`|

## Usage

- Check that required PHP version is installed.

```bash
php -v
```
- If not install the required PHP version, For example to install `PHP 7.2`.

```bash
brew tap shivammathur/php
brew install php@7.2
brew link --force --overwrite php@7.2
```

- Tap `shivammathur/extensions`
```
brew tap shivammathur/extensions
```

- Then install the required extension. See [Formula](Formula) directory for available formulae.

- To install `Xdebug` on `PHP 7.2`.

```bash
brew install xdebug@7.2
```

- To install `PCOV` on `PHP 7.2`.

```bash
brew install pcov@7.2
```

## License
The code in this project is licensed under the [MIT license](http://choosealicense.com/licenses/mit/).
Please see the [license file](LICENSE) for more information. This project has multiple [dependencies](#dependencies "Dependencies for this Homebrew tap"). Their licenses can be found in their respective repositories. The tap is a modification of [homebrew-php](https://github.com/Homebrew/homebrew-php) tap.


## Dependencies

- [gRPC](https://github.com/grpc/grpc "gRPC Upstream")
- [igbinary](https://github.com/igbinary/igbinary "igbinary upstream")
- [Imagick](https://github.com/Imagick/imagick "Imagick upstream")
- [PCOV](https://github.com/krakjoe/pcov "PCOV Upstream")
- [Protobuf](https://github.com/protocolbuffers/protobuf "protocolbuffers Upstream")
- [Swoole](https://github.com/swoole/swoole-src "Swoole Upstream")
- [Xdebug](https://github.com/xdebug/xdebug "Xdebug Upstream")
