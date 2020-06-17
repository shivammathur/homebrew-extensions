class AbstractPhpVersion < Formula
  desc "Abstract class for PHP Versions"
  homepage "https://github.com/shivammathur/homebrew-extensions"

  module Php56Defs
    PHP_SRC_TARBALL = "https://php.net/get/php-5.6.40.tar.xz/from/this/mirror".freeze
    PHP_GITHUB_URL  = "https://github.com/php/php-src.git".freeze
    PHP_VERSION     = "5.6.40".freeze
    PHP_BRANCH      = "PHP-5.6.40".freeze
    PHP_FORMULA     = "shivammathur/php/php@5.6".freeze
  end

  module Php70Defs
    PHP_SRC_TARBALL = "https://php.net/get/php-7.0.33.tar.xz/from/this/mirror".freeze
    PHP_GITHUB_URL  = "https://github.com/php/php-src.git".freeze
    PHP_VERSION     = "7.0.33".freeze
    PHP_BRANCH      = "PHP-7.0.33".freeze
    PHP_FORMULA     = "shivammathur/php/php@7.0".freeze
  end

  module Php71Defs
    PHP_SRC_TARBALL = "https://php.net/get/php-7.1.33.tar.xz/from/this/mirror".freeze
    PHP_GITHUB_URL  = "https://github.com/php/php-src.git".freeze
    PHP_VERSION     = "7.1.33".freeze
    PHP_BRANCH      = "PHP-7.1.33".freeze
    PHP_FORMULA     = "shivammathur/php/php@7.1".freeze
  end

  module Php72Defs
    PHP_SRC_TARBALL = "https://php.net/get/php-7.2.31.tar.xz/from/this/mirror".freeze
    PHP_GITHUB_URL  = "https://github.com/php/php-src.git".freeze
    PHP_VERSION     = "7.2.31".freeze
    PHP_BRANCH      = "PHP-7.2.31".freeze
    PHP_FORMULA     = "shivammathur/php/php@7.2".freeze
  end

  module Php73Defs
    PHP_SRC_TARBALL = "https://php.net/get/php-7.3.19.tar.xz/from/this/mirror".freeze
    PHP_GITHUB_URL  = "https://github.com/php/php-src.git".freeze
    PHP_VERSION     = "7.3.19".freeze
    PHP_BRANCH      = "PHP-7.3.19".freeze
    PHP_FORMULA     = "shivammathur/php/php@7.3".freeze
  end

  module Php74Defs
    PHP_SRC_TARBALL = "https://php.net/get/php-7.4.7.tar.xz/from/this/mirror".freeze
    PHP_GITHUB_URL  = "https://github.com/php/php-src.git".freeze
    PHP_VERSION     = "7.4.7".freeze
    PHP_BRANCH      = "PHP-7.4.7".freeze
    PHP_FORMULA     = "shivammathur/php/php@7.4".freeze
  end

  module Php80Defs
    PHP_SRC_TARBALL = "https://github.com/php/php-src/archive/master.tar.gz?v=php-8.0.0".freeze
    PHP_GITHUB_URL  = "https://github.com/php/php-src.git".freeze
    PHP_VERSION     = "8.0.0".freeze
    PHP_BRANCH      = "PHP-8.0.0".freeze
    PHP_FORMULA     = "shivammathur/php/php@8.0".freeze
  end
end
