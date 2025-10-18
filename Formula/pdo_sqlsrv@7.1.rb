# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo_sqlsrv Extension
class PdoSqlsrvAT71 < AbstractPhpExtension
  init
  desc "pdo_sqlsrv PHP extension"
  homepage "https://github.com/Microsoft/msphpsql"
  url "https://pecl.php.net/get/pdo_sqlsrv-5.9.0.tgz"
  sha256 "0fce417b33879fdae3d50cc1aa5b284ab12662147ea2206fa6e1fadde8b48c58"
  head "https://github.com/Microsoft/msphpsql.git", branch: "dev"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_sequoia:  "50de97a7ee85958d476bfd73e19ee7f4c211d0ab99dedfee010a596927a5fe7a"
    sha256 cellar: :any,                 arm64_ventura:  "01d9d6f4bb2cfa58a557e60d4d57f450c061bed00392ccc1c6cb8203de89c408"
    sha256 cellar: :any,                 arm64_monterey: "3844ccb94a634adf04a0ecc557f310fdd4a3ca3c710587fcb7230bae15029a4e"
    sha256 cellar: :any,                 arm64_big_sur:  "19e976d15a75979e951188a3ecffabc9a2c38395e5a77fa5d46c4c1e65d50371"
    sha256 cellar: :any,                 ventura:        "af8e1b2ebdaf90f00a38935cbf58f2c772a8c72dea5d716830607a9ca486bbf8"
    sha256 cellar: :any,                 monterey:       "50d055454a9db6249f8e87af3362538463e686a994238a9aeed920c820128fa6"
    sha256 cellar: :any,                 big_sur:        "acbe9d24050b284c54e53998cce2141941a8baf9353989421c9c4c963bd23245"
    sha256 cellar: :any,                 catalina:       "05573dd990205e9c949b23d48618ddea1bdc0b67c13b067771b3cb8068415b3c"
    sha256 cellar: :any_skip_relocation, arm64_linux:    "27ac291b67448c94d02e55a8055e3117df0032b08160675775317570e6d45b4c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "1aa1c99d40e2d877d3d59d16954ee42bdcf12e18cd67faf2c5c3963172320a15"
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
