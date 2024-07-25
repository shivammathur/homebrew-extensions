# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT84 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/82e63a06e273283f923b6c74cd1f4b99d9fc0204.tar.gz?commit=82e63a06e273283f923b6c74cd1f4b99d9fc0204"
  version "8.4.0"
  sha256 "371d49978e7a4d1b3f596bfd70fd876cc3b66f7100a7b72cbfd943c89ecae73f"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 52
    sha256 cellar: :any,                 arm64_sonoma:   "4bf41dfb8daa5efe117e5cd4475b936fb5a2ee347f28bbeebab9b9b5dab27df5"
    sha256 cellar: :any,                 arm64_ventura:  "dbb04da8521e08ea14964a9870456afe5d8d75ab4c0ad498ad29c65854b8f100"
    sha256 cellar: :any,                 arm64_monterey: "2bb0c248b4eb62600dfe29c4b6d51e0ee84b5ca586242aae09013655153793f1"
    sha256 cellar: :any,                 ventura:        "a93b0553c48d97ba6527dae92565d94ea48b0ab26994984d6fc10c51e3a556be"
    sha256 cellar: :any,                 monterey:       "096425ccada5793462d9edcf93559d2a4791b7bd9f64d0cc2f4235f84348456e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "60098340e87dbec80c1ef66ba610032b59d5918a276cb34370a612b663de57b8"
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
