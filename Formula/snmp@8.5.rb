# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT85 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/6e1b1900f00f2529c1330c03c5cb87e6f3cfa905.tar.gz?commit=6e1b1900f00f2529c1330c03c5cb87e6f3cfa905"
  version "8.5.0"
  sha256 "5a6b164f91b55d8fae998383b790c20e73b9a72d6dfdaec829150b28a9fcb788"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "8592c8665d7ca55902ebbd170ccb8102dfd090875d51e1210de16d35ffb729a7"
    sha256 cellar: :any,                 arm64_sequoia: "9d219dd8efd9c62be0a99fbff76d9cd68b716ec4249fb8fa3137218c93d767bf"
    sha256 cellar: :any,                 arm64_sonoma:  "c62a03a6fbcf4ec19dd35171e9f969025399f6e79833037d59bbf90330a750d1"
    sha256 cellar: :any,                 sonoma:        "5779fbcf328ddb9a6d46d8153c2fe6cf1782c7a3e7f3e464d81bcd2369230a54"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "aaf35268e91fc939ddc5628b34707d920325c30e379d70a79b46de6297677edb"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6b6c9083d9f77f46f84fa8e041b8501accac3b5a16e4a6351c9b3960dd4ee1b1"
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
