# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT74 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/4ab83a550530c864e4bef29b054f81f71874d8be.tar.gz"
  version "7.4.33"
  sha256 "1593ea9ebe9902aa1dcc5651e62de5cd38b67ac636e0e166110215592ab1f820"
  revision 2
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_tahoe:   "2b627913eeda420911fbf2f5cbab406dd1eac3452f5cab04f01bcb44cd5a112f"
    sha256 cellar: :any,                 arm64_sequoia: "ed8adeb12a4cd1ea67866941af18b79350b477c254377ee9930b67587c6b7429"
    sha256 cellar: :any,                 arm64_sonoma:  "5fda6811d9e901754c7de33a759e4d7cc9c2f646667a26537aaf169f411d9fae"
    sha256 cellar: :any,                 sonoma:        "31970a58cc0d481af2dd5affdcd26d1291b2acb0d58d1aaa00c1ab13d6f2c261"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "8d79310338f43fcd42980b8469c320e3ec6bb53f962a3a5e7b1fdce313d8542f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "9e4a3c57a5e4b3f9c72ecd3a9a40fd6c81d5c1854d51b22e4b02ee58cd0d330c"
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
