# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT74 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/6c44436630a8d8f82dba84314c50df7ac08c7534.tar.gz"
  version "7.4.33"
  sha256 "a1a7e475baf81b182bb87f5d295224e9261d09de84d35e59b9ad29926920d0e2"
  revision 3
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any, arm64_golden_gate: "a5e66ec98abf6bc7be8cefdabe7eabf8e3a3156666cd934fe576be046eae03be"
    sha256 cellar: :any, arm64_tahoe:       "a0affa33c00a3c8458474d2d79b7a05915fb0a9908353cd6412895647b89b911"
    sha256 cellar: :any, arm64_sequoia:     "c8ceb79e44d272730ce003acfe58d272c0ed11d5363739cf59c69d36904512b1"
    sha256 cellar: :any, arm64_linux:       "51d4adcc280800477de8202dce69eb79380e89ea8d14864bd8cdce9e1b24ac10"
    sha256 cellar: :any, x86_64_linux:      "c2bdfc8c5208952c9389baea2ca734abcdd137725e9ea9e6c3cf45e363550283"
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
