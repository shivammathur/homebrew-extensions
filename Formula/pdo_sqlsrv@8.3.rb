# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo_sqlsrv Extension
class PdoSqlsrvAT83 < AbstractPhpExtension
  init
  desc "pdo_sqlsrv PHP extension"
  homepage "https://github.com/Microsoft/msphpsql"
  url "https://pecl.php.net/get/pdo_sqlsrv-5.11.0.tgz"
  sha256 "c307d9bcada02bdc21f59b9f099031b90b30727757bca50fd42fd36159812e8a"
  head "https://github.com/Microsoft/msphpsql.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_monterey: "a7d16d4fee3c873776a9829cf82d40996db2262a2e8e88369298d668d631083f"
    sha256 cellar: :any,                 arm64_big_sur:  "bb9ae10ea2a1ab75fb03261a766c65bea64f8c955224ab47e4a014dc85a60faf"
    sha256 cellar: :any,                 ventura:        "b6704b0ca9939eec5f5d7033b48057c5cbf23ca96d4ce17cc9291330ca34c071"
    sha256 cellar: :any,                 monterey:       "0439586eafeee8f31c1c5c5ba4260bec9e0d60026772ae7d6aba453ef37e637b"
    sha256 cellar: :any,                 big_sur:        "ef8ca431da8806e1c3b4ddf12044ff8b3e9ba3cd970ded0608d3af34da0f7342"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "1035f6a87bed294f790623d5f9f23d312b1acf6e3edf4ebc45ddd9e875aac423"
  end

  depends_on "unixodbc"

  def install
    Dir.chdir "pdo_sqlsrv-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--with-pdo_sqlsrv"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
