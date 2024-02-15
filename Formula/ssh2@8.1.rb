# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ssh2 Extension
class Ssh2AT81 < AbstractPhpExtension
  init
  desc "Ssh2 PHP extension"
  homepage "https://github.com/php/pecl-networking-ssh2"
  url "https://pecl.php.net/get/ssh2-1.4.1.tgz"
  sha256 "7bca5b23f731db9d8ed0aea5db9bb15da8ff133b0fbba96102b82e95da4d8764"
  head "https://github.com/php/pecl-networking-ssh2.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_ventura:  "09fb49cc749978082bb561a23207747e9e8fd75159c7940b5ee27535761f79b0"
    sha256 cellar: :any,                 arm64_monterey: "9db185f68b897d8b77c5d6d362d76cd0819b716d65a99ad43d3b05435995f7ec"
    sha256 cellar: :any,                 arm64_big_sur:  "95fa6eba51da1f54d23c2b2b4c60818a9c5f0d45434ae97b4ff20ea812643a8a"
    sha256 cellar: :any,                 ventura:        "1bef1c48d87a7d2b2763022d94da2ddc6baf23f20cf3f779def93722afd6dbae"
    sha256 cellar: :any,                 monterey:       "723db44fcfd5949c6ca2ebd5eb3828f141556d561564a01ffa85d2c8c8bfee7e"
    sha256 cellar: :any,                 big_sur:        "3d0adbf2b2cefac385ad01893253dca64f487dede15279bba71d11b48f104ab3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b86c0d464c2f0f17d903ad7a767e3cc12f187ae3e934e5134610086f79db6a04"
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
