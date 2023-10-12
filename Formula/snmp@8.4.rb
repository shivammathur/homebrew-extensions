# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT84 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/63c8ce84ddaa0719a0d46039a2538ba9865c6a67.tar.gz?commit=63c8ce84ddaa0719a0d46039a2538ba9865c6a67"
  version "8.4.0"
  sha256 "62193d5e15b6eff8e5a67df774b7bde849c7ed208f3b65ede7199f98b8d4d49d"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 8
    sha256 cellar: :any,                 arm64_sonoma:   "54ab3ba855a64ecb41b2aee9d93b3c19646e96d114ec3b68110257adc2f1f088"
    sha256 cellar: :any,                 arm64_ventura:  "558af6587d2e96857571928aa8c992310157c89b601d324863f1a9825864aa9a"
    sha256 cellar: :any,                 arm64_monterey: "d5a6a0b39dba1b208d2d2cfabeec69320ae36f7d88d01a8c1c3cccb72a73d241"
    sha256 cellar: :any,                 ventura:        "152028092a37a3acc303e4ca49b6eaedbd1ef278c29c7edc773bc83e22054d49"
    sha256 cellar: :any,                 monterey:       "0038afa838288cedf9b02f8dfdf7ab9d36a6581b5184241cf49bd8773198fcdf"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "63a856b88b5674e26eda3e4a1ee3334abab83833bd7f4229ac59768e4ed1345f"
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
