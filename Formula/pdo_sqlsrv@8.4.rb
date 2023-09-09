# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo_sqlsrv Extension
class PdoSqlsrvAT84 < AbstractPhpExtension
  init
  desc "pdo_sqlsrv PHP extension"
  homepage "https://github.com/Microsoft/msphpsql"
  url "https://pecl.php.net/get/pdo_sqlsrv-5.11.1.tgz"
  sha256 "549855a992a1363e4edef7b31be6ab0f9cd6dd9cc446657857750065eae6af89"
  head "https://github.com/Microsoft/msphpsql.git", branch: "master"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "6ea487c7ed50e60521eec4a3ea2500c02210d01680fe665714088d189378e273"
    sha256 cellar: :any,                 arm64_big_sur:  "8d053369047d8f3bd569cbccd57cd4b275ab328dda30d0eaf3910dd9c59a8069"
    sha256 cellar: :any,                 ventura:        "012ad52c6e2db298bb13240faea32c94dc78ad6b0aa2cc80a54d8617cd3feb52"
    sha256 cellar: :any,                 monterey:       "a8c0f48f80e4365c47dc9cd1194b06a6cea8c60de6d13246d416ed32225c9350"
    sha256 cellar: :any,                 big_sur:        "15b6bf6f40708ed4a0066cbf1e5298a4b2f7f082de1e888077b6b23f00059842"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "1348f5ca627f72b1d27eecea8234b6dcead36846aab3a7e3d17b240a79e5cda2"
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
