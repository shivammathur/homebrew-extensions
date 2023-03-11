# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Sqlsrv Extension
class SqlsrvAT83 < AbstractPhpExtension
  init
  desc "Sqlsrv PHP extension"
  homepage "https://github.com/Microsoft/msphpsql"
  url "https://pecl.php.net/get/sqlsrv-5.11.0.tgz"
  sha256 "6e437af4db730ab995c597f960e98bac060fc220a8d51ee24877eb7f39090a09"
  head "https://github.com/Microsoft/msphpsql.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "adecb44c58c2c556fc3066b716f1c19545e8b487422986beb2e1b1a0a55664ab"
    sha256 cellar: :any,                 arm64_big_sur:  "9e5bc9a5042affc758784e797f68f73508fc944828289af87e575141a0dc6b4a"
    sha256 cellar: :any,                 monterey:       "963c00a4eee4c285d765299b06e268729594138fdd9345007c4c4b5639496dc3"
    sha256 cellar: :any,                 big_sur:        "9148198b64bac2077876c990458e65c676883a06df12904544a00ce7c500ed3a"
    sha256 cellar: :any,                 catalina:       "eba0b327d2e8623b32a1abf797d898a6507816e4bae473085b79bb50924e9a76"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "bf5b0a5d998ddb7a284fe0479b15f4de34bb0018097ff1e1a40bfc42d5d20cd2"
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
