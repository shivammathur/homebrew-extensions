# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vips Extension
class VipsAT83 < AbstractPhpExtension
  init
  desc "Vips PHP extension"
  homepage "https://github.com/libvips/php-vips-ext"
  url "https://pecl.php.net/get/vips-1.0.13.tgz"
  sha256 "4e655843e5ee8150c927c10853dfa0d2a3b924bc2453ed8fb5e5a2a90e686f8f"
  head "https://github.com/libvips/php-vips-ext.git", branch: "master"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_monterey: "2f34a1ba757114a36103622f6b6f24b4717450d8b2436ee56646812ccde59baf"
    sha256 cellar: :any,                 arm64_big_sur:  "be902c14f87c34330e205fb7000135e2fc2a16947268b4adee6e72b009d08bc0"
    sha256 cellar: :any,                 monterey:       "525ef074f7c9104d4b219b25644602bf3c53a601a8b2a359080d6117fdee21ef"
    sha256 cellar: :any,                 big_sur:        "7398d0a1065b3425d7b6e4a4654891c0053eb2afc5da9ec8be85ea85965c8251"
    sha256 cellar: :any,                 catalina:       "f5dfc48f373ee4011a3903a1cc131792a0a546067a0d16e96f93480a2edf7cd7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "6f80c1a549decb16bd690a2c4c4dbd1b237f1bc3402a4e62b715ec512e14de71"
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
