# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT85 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/2e0c011fb8d55ea1bc3e3dccb7e54f8bf3cae37e.tar.gz?commit=2e0c011fb8d55ea1bc3e3dccb7e54f8bf3cae37e"
  version "8.5.0"
  sha256 "465ee7fc77ebb754d0b6050f63323282d2c055871d05752e7680d84b57dcd292"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 35
    sha256 cellar: :any,                 arm64_sequoia: "03365f4b38a381da4a1f118e36a58aafe6aa095b4627721acbe03d5182e37be2"
    sha256 cellar: :any,                 arm64_sonoma:  "7ce7e96e38825b839fb27abd25acce3789df9a15ce247beaeade2cbcab9a7eb5"
    sha256 cellar: :any,                 arm64_ventura: "4e6e3e958ce0a48638cd201ca750aeb28f491286cfb9c2152db96ad60c00f937"
    sha256 cellar: :any,                 ventura:       "5c14bee7ae96856dabeb7e3abbd81409d3d6f3b9d4479996529f3c582110a8f2"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "1567967613c4cad091af33923e5a326729e3614de6bc58246c7fe05b665d125e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "fbf6188f18df6ced941cee4c6b25d234fa858b41c6da9481070a18b283cb8655"
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
