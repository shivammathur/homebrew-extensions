# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Sqlsrv Extension
class SqlsrvAT82 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia:  "7d02bc9a63ca815893c93c45a1537e21abff0cb4bcb7d5e20ea07faf3820ed38"
    sha256 cellar: :any,                 arm64_sonoma:   "2130ed41bc9528007dc69fc86ee2866bfdc8822405e4b463e050eaafc03d53f1"
    sha256 cellar: :any,                 arm64_ventura:  "f97ebb40b1e92ac270efca339670502f7830fdfa57d05fb951258d624632f201"
    sha256 cellar: :any,                 arm64_monterey: "9d2fe395f62088d32945b9a7f011af1fb027d119515b561c97a381d40311a916"
    sha256 cellar: :any,                 ventura:        "52295258d68b35d2b33c976ef231ad26455848effaf61ca6c5d68caab149d6c0"
    sha256 cellar: :any,                 monterey:       "494fe8421551b10b03d6da2aabe156bc764625bfe7715b6daa7c522fc1641c56"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "219587542d8b7884b17adb86e39789dc62f77b47587e72bad836398725725bc8"
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
