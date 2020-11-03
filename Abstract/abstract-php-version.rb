# typed: false
# frozen_string_literal: true

# Abstract class for PHP versions
class AbstractPhpVersion < Formula
  desc "Abstract class for PHP Versions"
  homepage "https://github.com/shivammathur/homebrew-extensions"

  module Php56Defs
    PHP_SRC_TARBALL = "https://php.net/get/php-5.6.40.tar.xz/from/this/mirror"
    PHP_GITHUB_URL  = "https://github.com/php/php-src.git"
    PHP_VERSION     = "5.6.40"
    PHP_BRANCH      = "PHP-5.6.40"
    PHP_FORMULA     = "shivammathur/php/php@5.6"
  end

  module Php70Defs
    PHP_SRC_TARBALL = "https://php.net/get/php-7.0.33.tar.xz/from/this/mirror"
    PHP_GITHUB_URL  = "https://github.com/php/php-src.git"
    PHP_VERSION     = "7.0.33"
    PHP_BRANCH      = "PHP-7.0.33"
    PHP_FORMULA     = "shivammathur/php/php@7.0"
  end

  module Php71Defs
    PHP_SRC_TARBALL = "https://php.net/get/php-7.1.33.tar.xz/from/this/mirror"
    PHP_GITHUB_URL  = "https://github.com/php/php-src.git"
    PHP_VERSION     = "7.1.33"
    PHP_BRANCH      = "PHP-7.1.33"
    PHP_FORMULA     = "shivammathur/php/php@7.1"
  end

  module Php72Defs
    PHP_SRC_TARBALL = "https://php.net/get/php-7.2.34.tar.xz/from/this/mirror"
    PHP_GITHUB_URL  = "https://github.com/php/php-src.git"
    PHP_VERSION     = "7.2.34"
    PHP_BRANCH      = "PHP-7.2.34"
    PHP_FORMULA     = "shivammathur/php/php@7.2"
  end

  module Php73Defs
    PHP_SRC_TARBALL = "https://php.net/get/php-7.3.24.tar.xz/from/this/mirror"
    PHP_GITHUB_URL  = "https://github.com/php/php-src.git"
    PHP_VERSION     = "7.3.24"
    PHP_BRANCH      = "PHP-7.3.24"
    PHP_FORMULA     = "shivammathur/php/php@7.3"
  end

  module Php74Defs
    PHP_SRC_TARBALL = "https://php.net/get/php-7.4.12.tar.xz/from/this/mirror"
    PHP_GITHUB_URL  = "https://github.com/php/php-src.git"
    PHP_VERSION     = "7.4.12"
    PHP_BRANCH      = "PHP-7.4.12"
    PHP_FORMULA     = "shivammathur/php/php@7.4"
  end

  module Php80Defs
    PHP_SRC_TARBALL = "https://github.com/php/php-src/archive/PHP-8.0.tar.gz?v=php-8.0.0"
    PHP_GITHUB_URL  = "https://github.com/php/php-src.git"
    PHP_VERSION     = "8.0.0"
    PHP_BRANCH      = "PHP-8.0.0"
    PHP_FORMULA     = "shivammathur/php/php@8.0"
  end

  module Php81Defs
    PHP_SRC_TARBALL = "https://github.com/php/php-src/archive/master.tar.gz?v=php-8.1.0"
    PHP_GITHUB_URL  = "https://github.com/php/php-src.git"
    PHP_VERSION     = "8.1.0"
    PHP_BRANCH      = "PHP-8.1.0"
    PHP_FORMULA     = "shivammathur/php/php@8.1"
  end
end
