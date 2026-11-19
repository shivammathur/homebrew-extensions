# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT83 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.3.37.tar.xz"
  sha256 "0237af84478b7a7649d3964153f1b8653d622550b846f56d63062de683fb86bb"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://www.php.net/downloads?source=Y"
    regex(/href=.*?php[._-]v?(8\.3(?:\.\d+)*)\.t/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "4b3405d17b65198c8c5d4825973d7676665eee1264724a8e7cf90a71e3ac4235"
    sha256 cellar: :any, arm64_tahoe:       "02936985a3012cc50087de9b748c6ee704594919bc3d6408d8df9711d5e5e793"
    sha256 cellar: :any, arm64_sequoia:     "135cf9407104ada98de96e5e92ecd5adf7d5a9318354984621a32218ade78717"
    sha256 cellar: :any, arm64_linux:       "6dceb468264733b8113fb5314e5006bf8e482a0e88c7e8db52bfb47ac2427167"
    sha256 cellar: :any, x86_64_linux:      "83fb8b128cf7f2b0ada4e22957cce7a8ece4fc911936fb40d0deed8e5988c553"
  end

  depends_on "net-snmp"
  depends_on "openssl@4"

  def install
    args = %W[
      --with-snmp=#{Utils::Path.formula_opt_prefix("net-snmp")}
      --with-openssl-dir=#{Utils::Path.formula_opt_prefix("openssl@4")}
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
