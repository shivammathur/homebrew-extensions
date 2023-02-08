# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT74 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/7328f3a0344806b846bd05657bdce96e47810bf0.tar.gz"
  version "7.4.33"
  sha256 "97b817fb1d8ace67512da447496c115e998397084c741e5bef4385f5fab3fb4c"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "9ec2cacd5686aed9d242f86343bc4410d71b197b79440321cef5d74a047b79ff"
    sha256 cellar: :any,                 arm64_big_sur:  "5e4dd519017022a7273e225b378d16291c3ac351a14ee37d6063003a08143ef6"
    sha256 cellar: :any,                 monterey:       "9949aa137d93d6de0579d370506f1b40e0ace3e979627474238a71acb43c2371"
    sha256 cellar: :any,                 big_sur:        "40dfe678a061ab43957e9aa62ae1c19bc8bcd7015a49489da5862dc7eb5942ca"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "3d663b12cf3fa7a969f1eebb527b09e4be4f6e26f0efee2189e7ed06d54a4ebe"
  end

  depends_on "net-snmp"
  depends_on "openssl@1.1"

  def install
    args = %W[
      --with-snmp=#{Formula["net-snmp"].opt_prefix}
      --with-openssl-dir=#{Formula["openssl@1.1"].opt_prefix}
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
