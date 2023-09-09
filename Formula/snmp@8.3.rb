# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT83 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/94eb3bdcbf34fb61ec66e8f949c86ed66bcbd727.tar.gz?commit=94eb3bdcbf34fb61ec66e8f949c86ed66bcbd727"
  version "8.3.0"
  sha256 "32184f1cd62a950516380bf407cf788e2144dd0bda621e6b02c7ad61b1c5a3c6"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 9
    sha256 cellar: :any,                 arm64_monterey: "3dcb062d50e4b04ed7eb8804729b050cb97ad9ce29d4afd59db952c310eb05c5"
    sha256 cellar: :any,                 arm64_big_sur:  "23f8368003652e3df57dcea77df0b64e68c9306eed6ff1911d908fc21c54ccc6"
    sha256 cellar: :any,                 ventura:        "5b95d0d13723b1b023185d0297ac9902cb8e3c8f5bab35d32f1b71fb8d6e3176"
    sha256 cellar: :any,                 monterey:       "1b413127ca09c70518dba5db835a5f63d1629cc37ae6bf8de76aae2ec41abec8"
    sha256 cellar: :any,                 big_sur:        "7de9984ad596692464ec79f39494906e354be30f78cc45873eeac50958e28a12"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "11ce8931fee5900298ac5d54e0364bd9a88607fdbde8bc73226bababc5cbce70"
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
