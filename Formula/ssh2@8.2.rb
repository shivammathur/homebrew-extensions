# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ssh2 Extension
class Ssh2AT82 < AbstractPhpExtension
  init
  desc "Ssh2 PHP extension"
  homepage "https://github.com/php/pecl-networking-ssh2"
  url "https://pecl.php.net/get/ssh2-1.3.1.tgz"
  sha256 "9093a1f8d24dc65836027b0e239c50de8d5eaebf8396bc3331fdd38c5d69afd9"
  head "https://github.com/php/pecl-networking-ssh2.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_monterey: "5d3fcbfede9de42c5718f6ee8b724db456b9900bebbc8f0106752db5c35776b3"
    sha256 cellar: :any,                 arm64_big_sur:  "5bc5a6bcf811dd166f40d513a498595b5a2c4467feb2f7edddeb65f6fc908eab"
    sha256 cellar: :any,                 monterey:       "8105493a2a1c049cd4effc53177b5ce27c28eb766998e51713bbb8d5dbee719a"
    sha256 cellar: :any,                 big_sur:        "2ccca8a1aa6f77024fcede335c4c46960c88bf5674e89bc59a0ac97d4b508f3a"
    sha256 cellar: :any,                 catalina:       "9911b5284ef160e43bce400753ff4b1c71ce7667240ea7bd0421219dfd037442"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "1c9e65325d1ebb4f421ad07342f227ef49e128ce9e11bee57e23f9240466ee4e"
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
