# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT84 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/ead679ecf8daf91840ec9324aa4b4814a3c445ab.tar.gz?commit=ead679ecf8daf91840ec9324aa4b4814a3c445ab"
  version "8.4.0"
  sha256 "c1ef4faba8a1a582b33f2d4b7c88a15ae08620ed46825a84c61e7c2f08373872"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 51
    sha256 cellar: :any,                 arm64_sonoma:   "58256c51a95ce72b68c2696f77b57042f8f5baeb8495a2388ed0b6721bc59b21"
    sha256 cellar: :any,                 arm64_ventura:  "b17c58d3f891808ddd4481a8e81290675ca4e2e54e6260cb8c578ed297c24ba1"
    sha256 cellar: :any,                 arm64_monterey: "fbf20be9cd142a91fdb6223a8e75c50eca66f0dc97a88b286d4009c97e75e3f8"
    sha256 cellar: :any,                 ventura:        "8ef7b77b8500c42ccc251b45f2e94bf9b6dc83b62aa5b60e3c49b02f21e790ef"
    sha256 cellar: :any,                 monterey:       "d06941c91962c75b3203581d60866a520accb405d045bb9dd98cd335361743b3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "09132c47eb8f2aeff85443388c067711904f79edccd574636ab1d4604cbc7389"
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
