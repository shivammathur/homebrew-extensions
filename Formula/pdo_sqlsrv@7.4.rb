# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo_sqlsrv Extension
class PdoSqlsrvAT74 < AbstractPhpExtension
  init
  desc "pdo_sqlsrv PHP extension"
  homepage "https://github.com/Microsoft/msphpsql"
  url "https://pecl.php.net/get/pdo_sqlsrv-5.11.0.tgz"
  sha256 "c307d9bcada02bdc21f59b9f099031b90b30727757bca50fd42fd36159812e8a"
  head "https://github.com/Microsoft/msphpsql.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia:  "ad0794a1c8877370ced64bab0f4e230b4229a42ad4ba91700a558a469e94fbf5"
    sha256 cellar: :any,                 arm64_ventura:  "fe382396012cb7fb404ef734275e20b32d1f581ec9580baedf2c07dde5563194"
    sha256 cellar: :any,                 arm64_monterey: "71c43543cdb559da211f357b71cc1e9750b344cd5dfec019bddcef8e51487b2b"
    sha256 cellar: :any,                 arm64_big_sur:  "46fa783462e6a240495e75d632ccec0b00926776ac9c5ead38d2d5c86b110397"
    sha256 cellar: :any,                 ventura:        "ff57937ef68fc1c33413eaf22bf4061bff315d210ec1ebbf75ca4fadad0573b0"
    sha256 cellar: :any,                 monterey:       "37629eebe8867b536779e603057e462bea58b75c11b1b77613ac291a74863c58"
    sha256 cellar: :any,                 big_sur:        "8c2c4d730c440170150092f4add431ff352c1c496f10b2a444d57c99a7eb9bcc"
    sha256 cellar: :any_skip_relocation, arm64_linux:    "45283611bd4c2c2f75863012e6287019a290fa6ed632df06b3873c049113d899"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "3851f2c3769e3f36708a6721a5d5a4bf682699ca12929371a0f75e99a3cd5eaa"
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
