# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT74 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/850206cc862858e460587305d0bfa802cc46ea2e.tar.gz"
  version "7.4.33"
  sha256 "d3d7b7ad536398743a06adba0c3bce23eae340e0f05d946a4059f01e841b7de9"
  revision 2
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any, arm64_tahoe:   "323b0d1c825c4b4e4d9f5fa4c85486d8dc5a410c37202054e78cab61fdb3810d"
    sha256 cellar: :any, arm64_sequoia: "6a10fcc3a1fa1a4baa8f4f379a6d8f1b851d0b4e88734fe4694701279eaf2c69"
    sha256 cellar: :any, arm64_sonoma:  "9bceb1d320b389a34a67cc3769765b25d0b258f2d42a1d7917ca69533a77dac8"
    sha256 cellar: :any, sonoma:        "3db1f3b2f24a2b1a021ef8026999ca458a59ab51dbea057d5f25bc5be60b85d3"
    sha256 cellar: :any, arm64_linux:   "4ed9133edbded1864ef30e47a0810bfc414aeca26db90d4fc45f98a844f0e01e"
    sha256 cellar: :any, x86_64_linux:  "beeae8f55ea40e7b614a2f24f73cfdc8b0b68acf5f352de873d3a0a0b9571735"
  end

  depends_on "net-snmp"
  depends_on "openssl@3"

  def install
    args = %W[
      --with-snmp=#{Utils::Path.formula_opt_prefix("net-snmp")}
      --with-openssl-dir=#{Utils::Path.formula_opt_prefix("openssl@3")}
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
