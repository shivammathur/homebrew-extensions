# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Sqlsrv Extension
class SqlsrvAT84 < AbstractPhpExtension
  init
  desc "Sqlsrv PHP extension"
  homepage "https://github.com/Microsoft/msphpsql"
  url "https://pecl.php.net/get/sqlsrv-5.11.1.tgz"
  sha256 "678ab60174be56b09c6916307700e716a4ff266ad53e43990a9d9740d4728463"
  head "https://github.com/Microsoft/msphpsql.git", branch: "master"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "0416e4f51230ec0f5aa212b1b0b8982f190a2bd64dc15a8d95121c41deb347ae"
    sha256 cellar: :any,                 arm64_big_sur:  "88706199d44ae73bd9c95726e7e8f6e3b6f99c4803f42969da091cc63b29dc16"
    sha256 cellar: :any,                 ventura:        "be821c67f6d357996899f6d7cbf3ac260d39c880f67b8d6e6ca54b925db66b9d"
    sha256 cellar: :any,                 monterey:       "c8b35c342931245329314b1794be7f236a4f2a4a58000e759b2c2ab13c24e77c"
    sha256 cellar: :any,                 big_sur:        "5fb58e36f3f4d5ae846c2e979b82afadc51c2348a7a9d83941214f350408eec6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "1c6f96105d0f1df5a7afbc5152b4369291e2f7f8a66e233e98e9129503afe8b7"
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
