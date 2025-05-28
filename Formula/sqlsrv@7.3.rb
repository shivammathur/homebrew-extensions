# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Sqlsrv Extension
class SqlsrvAT73 < AbstractPhpExtension
  init
  desc "Sqlsrv PHP extension"
  homepage "https://github.com/Microsoft/msphpsql"
  url "https://pecl.php.net/get/sqlsrv-5.11.0.tgz"
  sha256 "6e437af4db730ab995c597f960e98bac060fc220a8d51ee24877eb7f39090a09"
  head "https://github.com/Microsoft/msphpsql.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia:  "f1209cb35f705ab3083edd603d485ef93958e2b5b35e5a7cc4a7971eee4a0d63"
    sha256 cellar: :any,                 arm64_ventura:  "688375d211af9d91dd966bc5018c4f28973dbe7af8e1f65ea9914c4f667fdbe0"
    sha256 cellar: :any,                 arm64_monterey: "1b19469574e30a9b770d7502e9bfb01f7ec73cf53997ed1a9e8f3758e9b49837"
    sha256 cellar: :any,                 arm64_big_sur:  "a85a2fc309cb2b5699a8e731e271b46e19dd0d0c124d046782f3e4a4a0e0325f"
    sha256 cellar: :any,                 ventura:        "5a18808c3354f65d91d134a83a04e1145bfe6c855c01e310ac450b7135751c69"
    sha256 cellar: :any,                 monterey:       "73eb215d4bdff6cebb6ca29efe5fb5495e6ee48ed0efd3d21afd8241dc800581"
    sha256 cellar: :any,                 big_sur:        "f1ab9c53513251c14a2cf86d2c8a48bc032570019d01a96e1d4d5a83e94fdb1e"
    sha256 cellar: :any_skip_relocation, arm64_linux:    "1f472c59b0c787a0dd5c74c3115da6cbd4b0e78fb1d48e98d9cd4d75258e5374"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "e8c2e023c8fa45f14446c765e0eb105d8d3c46fdbe76c60e49f1f095d44a1bbd"
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
