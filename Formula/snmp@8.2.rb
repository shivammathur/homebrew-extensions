# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT82 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.2.4.tar.xz"
  sha256 "bc7bf4ca7ed0dd17647e3ea870b6f062fcb56b243bfdef3f59ff7f94e96176a8"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "dcd93bbfcb7b2e3b02722140749292c16a756e5b456264e034a7dc298d305d3a"
    sha256 cellar: :any,                 arm64_big_sur:  "bc12b14e10b9731461e0dba320f17965e273919b5b6ee32bea57e70b6c52f728"
    sha256 cellar: :any,                 monterey:       "f36e83265fa5e8c1648c35d7a65cc759a1543e16f5c21ed0ac6c15f2b315c542"
    sha256 cellar: :any,                 big_sur:        "41d77ad06935b2fe11d4e403962880041f66b6d686a68136e061451c546d709a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "f33efe3ca7612cd02f8777d07c9c1a4325e346a9f19c8f3d7bb067f0f0a1954c"
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
