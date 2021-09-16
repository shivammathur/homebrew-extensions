# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ssh2 Extension
class Ssh2AT72 < AbstractPhpExtension
  init
  desc "Ssh2 PHP extension"
  homepage "https://github.com/php/pecl-networking-ssh2"
  url "https://pecl.php.net/get/ssh2-1.3.1.tgz"
  sha256 "9093a1f8d24dc65836027b0e239c50de8d5eaebf8396bc3331fdd38c5d69afd9"
  head "https://github.com/php/pecl-networking-ssh2.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_big_sur: "fe90764efc4c2eeaa5d69dd8e396cdfcacd9fbf9e1644c470f9679bc6df5fba7"
    sha256 cellar: :any,                 big_sur:       "ee3c743c5fffbb658ad61c7f2c4ac02b2141a05f31100c1a5d1751bac515a868"
    sha256 cellar: :any,                 catalina:      "4949ef7dbf35e6de78237ef231e00f13da2a83933a1125582fda20f246543dfb"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a4e0c8793fd4b130e03b1a5b64ba450ffef1d488f95eb459298518e05f04690c"
  end

  depends_on "libssh2"

  def install
    args = %W[
      --with-ssh2=shared,#{Formula["libssh2"].opt_prefix}
    ]
    Dir.chdir "ssh2-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
