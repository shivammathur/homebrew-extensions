# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT86 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/1ac68e7b079b33b012c9f69b986b31852370f2ee.tar.gz?commit=1ac68e7b079b33b012c9f69b986b31852370f2ee"
  version "8.5.0"
  sha256 "5c3b494034eb0aef6dbc1ea15a2245610008c8d5c12b54698e508b6e30cba88f"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "176f4ae91b55bc4777fc6d134d0540ea9a66e73a0264f3c203e54a4a2128bcb3"
    sha256 cellar: :any,                 arm64_sequoia: "6d4f3ad94e02871d2a17fb20c087cfe26fe77078383567b6920368c020800434"
    sha256 cellar: :any,                 arm64_sonoma:  "aace315a2031a6e8c2f2d934db77930e03ec94d786b9c170f4dd97d126a43dd2"
    sha256 cellar: :any,                 sonoma:        "6b49996f35b19ddcaec51979ccdad89cdd369288273b20af5c266d170cd90e4e"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "ee1aa9ee6d53b0bb6be4d32f8756d535c49db9f3fab208c83716a6d3ed818629"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ab17ef5ac35accb6e1f0a60f293489ee2a4d559429eea4f3cc6a740ccee967c5"
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
