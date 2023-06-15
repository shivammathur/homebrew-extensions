# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT81 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.1.20.tar.xz"
  sha256 "4c9973f599e93ed5e8ce2b45ce1d41bb8fb54ce642824fd23e56b52fd75029a6"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "66253c5ca396091a34b1987b55553cb972c6fa87fc89339a1acba2bd6069a948"
    sha256 cellar: :any,                 arm64_big_sur:  "3a96c42a38f9bb635a8f743e3e3ea1b5c81f347b92091c6ba7b1ad0ca0437192"
    sha256 cellar: :any,                 ventura:        "4bf6b0b4c12a55c0aef79cca97bfa45926d5b1e929337fb3a49b4a8d38ed12ed"
    sha256 cellar: :any,                 monterey:       "0f360443604ea72d0acbe0591999501684297039e88d395db50e553b0c1a951c"
    sha256 cellar: :any,                 big_sur:        "ca9b4669086bdd645bd974a7ccf6f31e2c8ec669c68cb9dbaf44fdd92e554251"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b41c354ca7714d28f430e166e5ac85f8ac5643de3d646de70c3816d42648e067"
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
