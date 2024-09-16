# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Sqlsrv Extension
class SqlsrvAT84 < AbstractPhpExtension
  init
  desc "Sqlsrv PHP extension"
  homepage "https://github.com/Microsoft/msphpsql"
  url "https://pecl.php.net/get/sqlsrv-5.12.0.tgz"
  sha256 "a9ebb880b2a558d3d6684f6e6802c53c5bffa49e1ee60d1473a7124fc9cb72ad"
  head "https://github.com/Microsoft/msphpsql.git", branch: "master"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_sequoia:  "d6c686ed9c0e3ff8d1f991c761c1fd34feffea207b2fa4394bd22bdc099df8b9"
    sha256 cellar: :any,                 arm64_sonoma:   "7d6defc03cd5e6a783066fd856c203831487ef876590242e55ec7447ea0338e0"
    sha256 cellar: :any,                 arm64_ventura:  "633a0c4b5dc2d8360b68725315834e24c232207b436a467581dac63ccff537f3"
    sha256 cellar: :any,                 arm64_monterey: "7ce0fe8aed63d40ef2f417d2cf2b9915739884701736c249547349ae2312e7a1"
    sha256 cellar: :any,                 ventura:        "7b4b240d37bee6bb41713632ae4926e75723ee920def9858e06c7839f6384183"
    sha256 cellar: :any,                 monterey:       "267bcd1f8bc48ec9c9cf5a90c4d879ef6a99420c5950d5bf34ec4ddb2601f16e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "34f7056d6f15c6cf67019b6e57cab88ff42076c25bfb84c6b4b30823d514a187"
  end

  depends_on "unixodbc"

  def install
    Dir.chdir "sqlsrv-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
