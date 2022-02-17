# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vips Extension
class VipsAT72 < AbstractPhpExtension
  init
  desc "Vips PHP extension"
  homepage "https://github.com/libvips/php-vips-ext"
  url "https://pecl.php.net/get/vips-1.0.13.tgz"
  sha256 "4e655843e5ee8150c927c10853dfa0d2a3b924bc2453ed8fb5e5a2a90e686f8f"
  head "https://github.com/libvips/php-vips-ext.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "0dd149112a9925e3be268015583939bc86d7aad98db1c7b6c39dade246fdc395"
    sha256 cellar: :any,                 big_sur:       "0e07a20bfa813fa8bc7638b5fae290454d1bddbf271b8a25338b89da8bd2c455"
    sha256 cellar: :any,                 catalina:      "bb9371ff6d7b9efdc138f46286664162b1fa1ba3b3f072d5e31fe558619d9158"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a824496a55c4e958fdc8f51540bb79bcd0eb8af88e705d40c123e1b9580a3db0"
  end

  depends_on "vips"

  def install
    args = %W[
      --with-vips=#{Formula["vips"].opt_prefix}
    ]
    Dir.chdir "vips-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
