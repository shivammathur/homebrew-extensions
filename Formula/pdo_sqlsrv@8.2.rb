# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo_sqlsrv Extension
class PdoSqlsrvAT82 < AbstractPhpExtension
  init
  desc "pdo_sqlsrv PHP extension"
  homepage "https://github.com/Microsoft/msphpsql"
  url "https://pecl.php.net/get/pdo_sqlsrv-5.11.0.tgz"
  sha256 "c307d9bcada02bdc21f59b9f099031b90b30727757bca50fd42fd36159812e8a"
  head "https://github.com/Microsoft/msphpsql.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "142cd014c0a837a48062e89156b618ffc582aab68b1e0eea45526c640224e41a"
    sha256 cellar: :any,                 arm64_big_sur:  "8a14ce425c6e68ed69fa7e9981016e92e93119eae138c951585fef46b1c9aa5e"
    sha256 cellar: :any,                 monterey:       "4e6657cb05bed854053280a12b1f94e4ab86f8b72c0ee6aa2b2bd9a2fe36eec4"
    sha256 cellar: :any,                 big_sur:        "4e7f5026e4cb74d770acd35894b4b65978a282340dcabf6ea273f375ec1c623b"
    sha256 cellar: :any,                 catalina:       "3a660d0f228266a5c922d84dc38db89c8b36d45c21b07b30f097d371b9ec4e89"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "9d7914fa772745d7931e6a7307e502f068143c27ddf3f8f83c0221a0fbc6f4ca"
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
