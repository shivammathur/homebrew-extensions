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
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "SHA"
    sha256 cellar: :any,                 arm64_big_sur:  "SHA"
    sha256 cellar: :any,                 monterey:       "SHA"
    sha256 cellar: :any,                 big_sur:        "SHA"
    sha256 cellar: :any,                 catalina:       "SHA"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "SHA"
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
