# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT82 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.2.2.tar.xz"
  sha256 "bdc4aa38e652bac86039601840bae01c0c3653972eaa6f9f93d5f71953a7ee33"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "f2190028ea404442fac90591a42748ae614b54772aaeec274678149378cbb6cd"
    sha256 cellar: :any,                 arm64_big_sur:  "3c2522f946064d2dbe7055a69547a15069c193272d7b758fa1c367636ad7e310"
    sha256 cellar: :any,                 monterey:       "0bf0f66e734b3e10cc7e67b5a8472c1b6f5bc3d587e0d96908c206d599c7075e"
    sha256 cellar: :any,                 big_sur:        "0baf55d5722bed09f03ca0e84d2b5b3738fdf2253f0236be0d14a2ac7adbeae1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "f08b3fd8c6281f9e7c4a0e64e6ed6e4dd496400765e29fc8f2548f4320f88b53"
  end

  depends_on "net-snmp"
  depends_on "openssl@1.1"

  def install
    args = %W[
      --with-snmp=#{Formula["net-snmp"].opt_prefix}
      --with-openssl-dir=#{Formula["openssl@1.1"].opt_prefix}
    ]
    Dir.chdir "ext/#{extension}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
