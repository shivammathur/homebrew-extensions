# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT86 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/a3f0861f2e5c287b200bd5692e00569b10bb9173.tar.gz?commit=a3f0861f2e5c287b200bd5692e00569b10bb9173"
  version "8.5.0"
  sha256 "9c1bc56952dd5bd685653c09ab418cfb6de030491f8df86e7200a47cc49809ac"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_tahoe:   "795ac355fa215063a2085d694d8ad15c19927c0fb850663f5c2d915342b95875"
    sha256 cellar: :any,                 arm64_sequoia: "377835dd8c4544ce313428191ed53bacc72f9d4003d59a412c1521bd2556047a"
    sha256 cellar: :any,                 arm64_sonoma:  "639887ce9ed1117acc852285088e8e750011c86e578cacd40f6cb94edeea8e62"
    sha256 cellar: :any,                 sonoma:        "abe6fad86e951b6c8f4bcfa70b2f736c7c5a1591f665988deb3ee88f96415c91"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "3a7362babd2ebc10f12c71919ebda1222f2abe7b04528d8e605886f837dfd817"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "0a4b75c85076c71854e65e270967305fb6490a8ab1f671c23eeefd3757f6123c"
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
