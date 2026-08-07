# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo_sqlsrv Extension
class PdoSqlsrvAT80 < AbstractPhpExtension
  init
  desc "pdo_sqlsrv PHP extension"
  homepage "https://github.com/Microsoft/msphpsql"
  url "https://pecl.php.net/get/pdo_sqlsrv-5.13.3.tgz"
  sha256 "198a7b37da0658d36a93d158a0ec179b137b3a4d241c90a6650ae9ee8f91ec4a"
  head "https://github.com/Microsoft/msphpsql.git", branch: "dev"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/pdo_sqlsrv/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "97b650380c8c96c9901279c5539e3693b1d84b161b552ce53e123a4cd3038464"
    sha256 cellar: :any, arm64_sequoia: "89ac70a0e9f964e2e2d9cfa6829eb920e1b08e7b348401aa3c177acf191fd403"
    sha256 cellar: :any, arm64_sonoma:  "ba8f49df180c03a393a83bd8a4ee50d220a865cb5012ef8e0abdda4eb095ba38"
    sha256 cellar: :any, sonoma:        "a4517997e85c7d78f5c2bc23a925ab7c78c8b0459b45756c33b1a5b75687160b"
    sha256 cellar: :any, arm64_linux:   "e08614166ae2c912af23b8c6f53967ca9684cf3b58933efea875141346adc790"
    sha256 cellar: :any, x86_64_linux:  "14845b412f5b41a78896b78c1431f01941f669df5e65bbc36fde717e8be3cdea"
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
