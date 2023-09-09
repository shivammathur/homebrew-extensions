# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo_sqlsrv Extension
class PdoSqlsrvAT81 < AbstractPhpExtension
  init
  desc "pdo_sqlsrv PHP extension"
  homepage "https://github.com/Microsoft/msphpsql"
  url "https://pecl.php.net/get/pdo_sqlsrv-5.11.1.tgz"
  sha256 "549855a992a1363e4edef7b31be6ab0f9cd6dd9cc446657857750065eae6af89"
  head "https://github.com/Microsoft/msphpsql.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "fdbd805b7a0f1f78e6b6c5b64f1897f1a347dbbd3e9d5a5612ce4c8547cf46e3"
    sha256 cellar: :any,                 arm64_big_sur:  "6ac2cad2220a6498c24a20d3d9bdf3d569537e74610164c1b81781b904cc4aac"
    sha256 cellar: :any,                 ventura:        "65e1a2af5ec91d2579ba9ff44e8da7a4e185c8fe4f82f40ca225908f33a354f1"
    sha256 cellar: :any,                 monterey:       "e7a67e65b493dc0b02efdc7ae7470f75004c078254b27f854f2ab60a074d276c"
    sha256 cellar: :any,                 big_sur:        "ed9629c60b10b94443a31b3b4196584626eb8ae7729561cb05ef3c610cb4c939"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "1ceb0f0e23fa7861003b9dc04612669a0d096d6b1d30bab1853540341defb6b7"
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
