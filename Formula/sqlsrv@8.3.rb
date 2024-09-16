# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Sqlsrv Extension
class SqlsrvAT83 < AbstractPhpExtension
  init
  desc "Sqlsrv PHP extension"
  homepage "https://github.com/Microsoft/msphpsql"
  url "https://pecl.php.net/get/sqlsrv-5.12.0.tgz"
  sha256 "a9ebb880b2a558d3d6684f6e6802c53c5bffa49e1ee60d1473a7124fc9cb72ad"
  head "https://github.com/Microsoft/msphpsql.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia:  "be109209e52865be34738566bff9af7d95c0920f4dd3c631836341d85ae70afd"
    sha256 cellar: :any,                 arm64_sonoma:   "f4711e329b58ce82e6e7540329fa4fd6a51dfbacb6f08c12a693ec54153c075a"
    sha256 cellar: :any,                 arm64_ventura:  "9bb23f4a15aee903ff0f00c359e7d79281597712bc897b511f324af730d5547b"
    sha256 cellar: :any,                 arm64_monterey: "f36ac5bc6776d29d186d3310e7db649059777f7a4d41e87db257c862c7a6ccc5"
    sha256 cellar: :any,                 ventura:        "550523605d989ddac073509e0db8576b496656779eb3f49fbb8aed79c1d97b4c"
    sha256 cellar: :any,                 monterey:       "845998b823de7d3e2048d115035c72e8fd743abd0e24e8e2c731a9476b8cc193"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "2ddfb67e91248736c5d22a9afa28f19722d13db92e9d86081f146432b1759550"
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
