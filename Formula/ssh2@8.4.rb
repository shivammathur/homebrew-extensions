# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ssh2 Extension
class Ssh2AT84 < AbstractPhpExtension
  init
  desc "Ssh2 PHP extension"
  homepage "https://github.com/php/pecl-networking-ssh2"
  url "https://pecl.php.net/get/ssh2-1.4.tgz"
  sha256 "988b52e0315bb5ed725050cb02de89b541034b7be6b94623dcb2baa33f811d87"
  head "https://github.com/php/pecl-networking-ssh2.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "d2e7d6003076504eb2915833aa49b50ec2644c7e858786011fe89da096b3a089"
    sha256 cellar: :any,                 arm64_big_sur:  "f419ce80f6441e809bbcb7145b903055e1bdbbc45e51096b86653944ab3d3ea0"
    sha256 cellar: :any,                 ventura:        "a67704182ecc45ff625b4a1cf6b93a8024a671cee583a13264dcb31cb978ba0e"
    sha256 cellar: :any,                 monterey:       "1b133f7b3d100ffeea64279a7364cf7aa02cd787eebe814e6cdc19ff802d521c"
    sha256 cellar: :any,                 big_sur:        "31d580c37c3b93c253eb2a741440a93f445cbf89109789c40133bd70465b077d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "211da9c58c44626b31142443567cc3e07a474e11d7a4855db60ff5ca63dd26d2"
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
