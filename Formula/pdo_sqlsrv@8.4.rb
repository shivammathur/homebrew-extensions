# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo_sqlsrv Extension
class PdoSqlsrvAT84 < AbstractPhpExtension
  init
  desc "pdo_sqlsrv PHP extension"
  homepage "https://github.com/Microsoft/msphpsql"
  url "https://pecl.php.net/get/pdo_sqlsrv-5.12.0.tgz"
  sha256 "22f0cb17b45f0deccd0bba072ee0085ff4094cd6ee2acc26f7f924975ef652c6"
  head "https://github.com/Microsoft/msphpsql.git", branch: "master"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 4
    sha256 cellar: :any,                 arm64_sequoia: "23ff805434f987112683e9d92e42e16a8a961788c6151bab8f01e917dc4e3759"
    sha256 cellar: :any,                 arm64_sonoma:  "94a407254d830929227b2d8137d28e053bac1f50a1da933cb3dad13504057ce7"
    sha256 cellar: :any,                 arm64_ventura: "dab3eef1ab7895e4880a6f7a4a580dcb7fa9e6c9288954fc1585f5d29587d2f4"
    sha256 cellar: :any,                 ventura:       "5624e020099fc5ba8ac440e019ecf65aa4ec1ee5bf5ac0cd64d47c692920878a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f4090e9b5cc37d2c1ab13a135dde0f0593769c0406352a81b8003f929e1513ac"
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
