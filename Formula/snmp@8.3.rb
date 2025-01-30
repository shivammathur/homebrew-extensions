# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT83 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.3.16.tar.xz"
  sha256 "40d3b4e6cac33d3bcefe096d75a28d4fb4e3a9615eb20a4de55ba139fbfacdd5"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "8444606d6763c381d01514ffd5d680df5c440235205eea1772772cd5f0bd8638"
    sha256 cellar: :any,                 arm64_sonoma:  "adc95940337da563e07426baa33215ee90ec5039f5c5394c1013f951ce73ac6d"
    sha256 cellar: :any,                 arm64_ventura: "cb74d3ad49f7cb9b615fa9ab82742cfcaae54f87e0be22c60fbc87c6d4faf678"
    sha256 cellar: :any,                 ventura:       "957bdb65e3b949460a1116dfdba5c4cf99d710531a9711bd5183077c4ef730e6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8415a4dfd442385dc3e367a0560b4c7307096f3de953916c74d45b6c1504ead4"
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
