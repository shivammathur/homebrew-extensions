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
    rebuild 1
    sha256 cellar: :any,                 arm64_big_sur: "747c159f6d7480a42830121198abf898ffb3c1f6229af9a2255f185c286d98fd"
    sha256 cellar: :any,                 big_sur:       "cd8302277b1226936f9da8dc1f0d458e338dfcdd358a3e0edd7d819c9157358e"
    sha256 cellar: :any,                 catalina:      "cb2e4e1dbe52b729f5f4ddc50f75309031a862f2f1c1610249b85fa17fc52331"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d64fdaa9264b12b53f8def1ec0aee23e60aeb179613df7ad9504b6d6894f26e9"
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
