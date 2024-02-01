# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo_sqlsrv Extension
class PdoSqlsrvAT81 < AbstractPhpExtension
  init
  desc "pdo_sqlsrv PHP extension"
  homepage "https://github.com/Microsoft/msphpsql"
  url "https://pecl.php.net/get/pdo_sqlsrv-5.12.0.tgz"
  sha256 "22f0cb17b45f0deccd0bba072ee0085ff4094cd6ee2acc26f7f924975ef652c6"
  head "https://github.com/Microsoft/msphpsql.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_ventura:  "7219bb7d4a8c616e4284df73da33101d3eeea3eece6d453b3ae00cf64518c68e"
    sha256 cellar: :any,                 arm64_monterey: "2ebd2272f37d36fababec3db1447d5f527d94b48dd27eaa834c61c4819f65364"
    sha256 cellar: :any,                 arm64_big_sur:  "739090e87fb295caeabda37f5316f401f2fd3e84d42e94dd72c7aa911e09a777"
    sha256 cellar: :any,                 ventura:        "17e66d498f65a1f63a3ab1627b1b66914dea63df959eed30e21e629621c8ff58"
    sha256 cellar: :any,                 monterey:       "944b9fc3bcd22d769160921eb2e7e0062e515e13879ad5fde10012e053e73009"
    sha256 cellar: :any,                 big_sur:        "bf0f553a1303f5f1071c98b7c4a9f3f053d5eae8a09a9e9212859e46b8e6544a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "88d5d081dbfc2ede3a83989d3e475b1c503f4f1f3bc3cbd64813e7e2bf50a073"
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
