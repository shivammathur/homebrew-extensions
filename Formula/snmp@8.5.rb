# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT85 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/d85662d6cc2c6d5f69403f6fb2001ff78e1bd174.tar.gz?commit=d85662d6cc2c6d5f69403f6fb2001ff78e1bd174"
  version "8.5.0"
  sha256 "4f98bf1c60c61b8ac67742c83e6a058b72e7a81ab8b67c709a942fc6b870f386"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 41
    sha256 cellar: :any,                 arm64_sequoia: "6f9c2ab43c0989b906f819347ee320a0de1de2cfa94d597df5674dd306979e04"
    sha256 cellar: :any,                 arm64_sonoma:  "6a915286849e8b4abc1e5773b0df2f7bda1c4fda7daec7c6a70408683ad7ed12"
    sha256 cellar: :any,                 arm64_ventura: "7e2e11b83b22028d30878e49707d10529857be9e107ccdbf83540c082334963d"
    sha256 cellar: :any,                 ventura:       "d45f1ee75a90020f4bb3d3803411a64c535555425a759b193c22d2838c0f2a5e"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "4c6d57f524bdad7d36c8712054ee3d367629fc4d21e83e395313cb7d2e8b2e1f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4bd5760bf4bf7dda8e53adcf53245d5a9847c4c6e518ec5b41fb659076778e48"
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
