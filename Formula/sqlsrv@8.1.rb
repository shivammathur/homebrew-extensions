# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Sqlsrv Extension
class SqlsrvAT81 < AbstractPhpExtension
  init
  desc "Sqlsrv PHP extension"
  homepage "https://github.com/Microsoft/msphpsql"
  url "https://pecl.php.net/get/sqlsrv-5.12.0.tgz"
  sha256 "a9ebb880b2a558d3d6684f6e6802c53c5bffa49e1ee60d1473a7124fc9cb72ad"
  head "https://github.com/Microsoft/msphpsql.git"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/sqlsrv/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia:  "505537ac63dbd1b7d2774691a472ae988f5c25813eb4b63976119e5c9ff9e744"
    sha256 cellar: :any,                 arm64_sonoma:   "2ddb772c276b5e2d05a80d835a811b202322905f41039c759a59a12dbb9b59a8"
    sha256 cellar: :any,                 arm64_ventura:  "526c8cbb12786becf9d21ddf7a39bb6d22247fd9dc2d21860b93db9299ee12f4"
    sha256 cellar: :any,                 arm64_monterey: "bb3e2f250ff8c71f303d7c639e4cf79c1f9681cd9c1bc1b4ff0445e582a8021f"
    sha256 cellar: :any,                 ventura:        "7698c7e6b4bfdd3fe478f2e0b5645a5656808b5440108d06ea0416afeceb08ba"
    sha256 cellar: :any,                 monterey:       "c492cabfb2e70e8bf9abbf854418770935a70e102a362a894ac9a8d0bc1e843c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "3d8756ac447b0d303a8e5a0edd6ee8e264fb88d4e32b02f9236713302169a4ef"
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
