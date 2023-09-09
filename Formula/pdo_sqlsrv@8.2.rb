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
    sha256 cellar: :any,                 arm64_monterey: "012d54c52b87941d2b584f34aafd53080b058b8ebf3c6707738440b7ef048451"
    sha256 cellar: :any,                 arm64_big_sur:  "423eee6ef30931ecab351740a1bc90f4b6e80ce6ea586db20cd8318206f3c9e3"
    sha256 cellar: :any,                 ventura:        "1c15584eb444176dce5bf7a794bcf22d51a54b779a4cb70fb4ad48c0ea474453"
    sha256 cellar: :any,                 monterey:       "62d5dbe19fa38f621c26658adacf2b9cce9cfbad6628eb78c645bfcd4d4b23eb"
    sha256 cellar: :any,                 big_sur:        "1857b5f679d5635d0cf1144c512472c9b471f734377ee2372b6c79cf401f2ed3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "531e3bef91dfc9ae8c36138e3736464c620b4127693a2baff74f2eacba6583e0"
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
