# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT83 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/4077dad871377fba8fd66d1dddb6741adaa6212e.tar.gz?commit=4077dad871377fba8fd66d1dddb6741adaa6212e"
  version "8.3.0"
  sha256 "43693c7dcc9f78a4a05939ea516061d0a326c531310dca2f902b504373fc6313"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "5243483547176e15ed80095b56aa133d1afb63725230e70140a7b513d44e2362"
    sha256 cellar: :any,                 arm64_big_sur:  "3a2b2d9906a50c29dc3216451f226c28330d481841fb8d51c05485f7d190a82c"
    sha256 cellar: :any,                 ventura:        "e547d2ff6f71cc5e299b1b3dd3bbd8f94de3cf1fda9f74a7450382ddd4903ecb"
    sha256 cellar: :any,                 monterey:       "e81254678e8075615191ded4a2c9703897fffc723e274b93945e11e33f41951c"
    sha256 cellar: :any,                 big_sur:        "104663ca86ce60d030a5b156ec46c5aff1f7b9ad6404a97e121b387be954fc93"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "6119cc7e22fcf5469d363c0bc56fcf3e160729ef3234a4659669b05a288147c8"
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
