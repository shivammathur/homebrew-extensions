# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo_sqlsrv Extension
class PdoSqlsrvAT82 < AbstractPhpExtension
  init
  desc "pdo_sqlsrv PHP extension"
  homepage "https://github.com/Microsoft/msphpsql"
  url "https://pecl.php.net/get/pdo_sqlsrv-5.11.1.tgz"
  sha256 "549855a992a1363e4edef7b31be6ab0f9cd6dd9cc446657857750065eae6af89"
  head "https://github.com/Microsoft/msphpsql.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "bc6e7d1a56b0685bcec8e352de2dc058a210d9c0a1eb40b03c01cd35dbd78ec8"
    sha256 cellar: :any,                 arm64_big_sur:  "10b6ca47cfea9c63161aecc750be03f36a52897e69c265eab846c2a580d8d33e"
    sha256 cellar: :any,                 ventura:        "fb11c2fb70b1629f5b573ab72cfc8761ba0d8557720d19644b18cf7803cfdf39"
    sha256 cellar: :any,                 monterey:       "45130008b2c96dbf831c61c4f4ed782e7331a6f60ea36cce1006b62f3d211bc3"
    sha256 cellar: :any,                 big_sur:        "7d415e79c09982a315b64b3038edc31ba434ef9bffedf35d99c131bbedd8c1e7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "77b55604ffbe44aa4fd7f2161fd9c1d9520501077c36734fb6e72e4f3369fdfb"
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
