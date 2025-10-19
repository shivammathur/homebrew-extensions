# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Sqlsrv Extension
class SqlsrvAT74 < AbstractPhpExtension
  init
  desc "Sqlsrv PHP extension"
  homepage "https://github.com/Microsoft/msphpsql"
  url "https://pecl.php.net/get/sqlsrv-5.11.0.tgz"
  sha256 "6e437af4db730ab995c597f960e98bac060fc220a8d51ee24877eb7f39090a09"
  head "https://github.com/Microsoft/msphpsql.git", branch: "dev"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia:  "0a8d16103e5a38448614228dcefb814b379572b6bf4d7a12048069d68512b182"
    sha256 cellar: :any,                 arm64_ventura:  "834b50ca9509fd8efac2dc413ce31b35ab4ef836eaa02efbd5526ce8c79a16cd"
    sha256 cellar: :any,                 arm64_monterey: "0cefa16ccd995ad5b8353ac8450132fe7c8fd7694e9247350db7904288faaeec"
    sha256 cellar: :any,                 arm64_big_sur:  "cadd74cd7a25fd94394336c51fb69ed5efc20b806dab2c470dec605caf3e26d4"
    sha256 cellar: :any,                 sonoma:         "dbd14c1746e23ea60a6396d233750bd1712938d2021f4d9326236c04552a6fe7"
    sha256 cellar: :any,                 ventura:        "6091732309bf8fa57c5509b3d7d0647b433b393d77baf08cbc9d47b4deea116b"
    sha256 cellar: :any,                 monterey:       "6b3f61ab89ff36f28a05b67e74c4b4b6f42a65e55f1f2674f5f442784f5fe5ca"
    sha256 cellar: :any,                 big_sur:        "3fbf478bc5d9814d680acb8b76d03ed96eb80fece260d9bf24cda8912491d545"
    sha256 cellar: :any_skip_relocation, arm64_linux:    "c809ec90efab36fa36b68614a417f016354af80ab8aaca5d719bee583a45483a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "4295412f278617a6c2a4617cf155adceed62f5d581a3a56e5b867cd3a340ff98"
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
