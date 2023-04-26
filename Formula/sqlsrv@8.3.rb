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
    sha256 cellar: :any,                 arm64_monterey: "d771dd2172f645d8a25174ae08ff9569e970831e0450f9c31041ec7b9ddd9862"
    sha256 cellar: :any,                 arm64_big_sur:  "161ffc304d49b48b0d2cb6d58c0fd94ad939b795360425fd6d4e1e6c2ecf8ce6"
    sha256 cellar: :any,                 ventura:        "06f6d9d997d31f551ff74aee64bf25221b88d5f419e9271ad08748ce58044eaf"
    sha256 cellar: :any,                 monterey:       "89dab0d46a1bab4fd79c31b0343117170753d969155767a91050eff7d0e30790"
    sha256 cellar: :any,                 big_sur:        "dd975fd4b139cd9fa651679bd26af28d561fb12f8bfc383e9677d6a6fe2cc0ac"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "3f28be21f13e623f88726cc4765f002bf9d0fde164c5006ca66a3807a65c0819"
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
