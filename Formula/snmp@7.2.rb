# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT72 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/6dd0dcf6e1eeb3f6fcba9b3269ca0803d7bbaa2d.tar.gz"
  version "7.2.34"
  sha256 "7aadc0a75d70efb425f8d74ea9e1a4a6826d5adfaa9807ed8d034d7cef1a7aff"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "381566d1a8177172101ae518f9cb24e627e43f73290ba319ec70791cc5443bed"
    sha256 cellar: :any,                 arm64_big_sur:  "dc1399a94c704ad553731552a6ebdb51b765227e2304ab999b20b938c626d975"
    sha256 cellar: :any,                 ventura:        "718567cc78d41bb2144cc1fb02070a4481072c93710559f366311ccd4e26fa92"
    sha256 cellar: :any,                 monterey:       "6ef9eac706586ab9fb7c67e4c2f80635095432b841635d71d04d55f03090961e"
    sha256 cellar: :any,                 big_sur:        "a4a1b1d2562980c73fd6bee1ce2d224d6143ef3648bae00fb7c6c067530fd557"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "90598bafca81e1ed2b05e0aa6690cae3a8279a29930810daa015de4b9f474504"
  end

  depends_on "net-snmp"
  depends_on "openssl@3"

  def install
    args = %W[
      --with-snmp=#{Formula["net-snmp"].opt_prefix}
      --with-openssl-dir=#{Formula["openssl@3"].opt_prefix}
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
