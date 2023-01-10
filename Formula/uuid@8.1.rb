# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class UuidAT81 < AbstractPhpExtension
  init
  desc "Uuid PHP extension"
  homepage "https://github.com/php/pecl-networking-uuid"
  url "https://pecl.php.net/get/uuid-1.2.0.tgz"
  sha256 "SHA"
  head "https://github.com/php/pecl-networking-uuid.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
  end

  depends_on "libuuid"

  def install
    Dir.chdir "uuid-#{version}"
    safe_phpize
    system "./configure"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
