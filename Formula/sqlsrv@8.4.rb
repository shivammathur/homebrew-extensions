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
    sha256 cellar: :any,                 arm64_sonoma:   "7e53ce25f3b5d62217e996d9b6e8cbec8009fd7b72a619b48b4576eb3e48a49d"
    sha256 cellar: :any,                 arm64_ventura:  "cef095963fa3b3c75d44d03fa48be2bf817c1dcadeaa16920aca75393177548d"
    sha256 cellar: :any,                 arm64_monterey: "c0c4c48f9ce1f94abf82d40fc0ba70d7c17519be7b9b1b9a89b043c80ba11328"
    sha256 cellar: :any,                 ventura:        "993e7621e93d101599152ea71fc0ffb61330b64f8089ae859381637cb720b39b"
    sha256 cellar: :any,                 monterey:       "fab2fca247167f335b903f800276d06f162fcf5fbe6fd18eb200f6cbaf5fbef1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b486ebbd0e15f996afbe8ae6e67118ade657773bf75f283552b765e582bab70e"
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
