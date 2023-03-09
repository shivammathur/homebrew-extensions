# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo_sqlsrv Extension
class PdoSqlsrvAT80 < AbstractPhpExtension
  init
  desc "pdo_sqlsrv PHP extension"
  homepage "https://github.com/Microsoft/msphpsql"
  url "https://pecl.php.net/get/pdo_sqlsrv-5.11.0.tgz"
  sha256 "c307d9bcada02bdc21f59b9f099031b90b30727757bca50fd42fd36159812e8a"
  head "https://github.com/Microsoft/msphpsql.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "75dcb553cbae23779d7886d2f582cc5358e5f0a2702b835a4bf12b9efffdbd9c"
    sha256 cellar: :any,                 arm64_big_sur:  "77db18d1b1976b1f6c62c4d7883088e6eebee4e400a7fad979cd2f0e1a6171a0"
    sha256 cellar: :any,                 monterey:       "fe9636aa698b50474a406ec7ea2f031ad87a4b7dbba607c9583e9c818dc8117c"
    sha256 cellar: :any,                 big_sur:        "eeeb7fefc8b9e3557789da10f0d8c16b518fe25bd8d4e400fb6e9a9f4855a20a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "5fab9d71db23012233022bdce6a68cb4a1a0866738c1b37d64b76d7e85c5b0ae"
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
