# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ssh2 Extension
class Ssh2AT73 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_big_sur: "415a2ab19bb891fac46c8d0a6f5b3f2ce7cbb3f94ad9883a47712ba64b0295de"
    sha256 cellar: :any,                 big_sur:       "d6db2f1bdfb1420e2e7004e79ebf4e435b6d10175b72fa836870571e7133884f"
    sha256 cellar: :any,                 catalina:      "c31d162a02263ca4283a939945035f1b897d1b7a2c783f10406a188e48ca8dc5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "94e7953230e9aba460ca2c032d7b9cdcb52a1a786045fc95960715d99552dc25"
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
