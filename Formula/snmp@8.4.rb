# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT84 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/221b4fe246e62c5d59f617ee4cbe6fd4c614fb5a.tar.gz?commit=221b4fe246e62c5d59f617ee4cbe6fd4c614fb5a"
  version "8.4.0"
  sha256 "aa4bbae2504daf8c2e1b9ac781a44ea179f208feb762990a49907edeaaf9266d"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 9
    sha256 cellar: :any,                 arm64_sonoma:   "a9e9a0ec4ffb28ad101f248355ba3fce69bc0f1afd40325f142e225918605e6a"
    sha256 cellar: :any,                 arm64_ventura:  "dad1ea47f837da8c567e236cd466cb7debb5a29df87b8e29c1ec229cd11ace7c"
    sha256 cellar: :any,                 arm64_monterey: "b712bf3af8889911039f58f56bff683db9355f0a2f443269ddb65d355d99cbd9"
    sha256 cellar: :any,                 ventura:        "69e62ce47560fb0ca7a8075b0a8a940344597d2ee2d6190f1f63975fcf1c6bdf"
    sha256 cellar: :any,                 monterey:       "d9a8e2eb42166e86d26896818ad902c3807a75b9904ff162be2d852ea3fad6e4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "a13eee6abe346435c02630f4c0ce51966542836a710c9a23f1e8bd6b503e1ec6"
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
