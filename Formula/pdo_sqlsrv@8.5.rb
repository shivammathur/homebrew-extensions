# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo_sqlsrv Extension
class PdoSqlsrvAT85 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_tahoe:   "76699f11e49eca2b526e473b5af299e08cdf606d4f803f44da5daf3f094445d4"
    sha256 cellar: :any, arm64_sequoia: "fb46d082321a98f65548d5c7e17ed2bd046f7fe6040f3d093956995812af06fd"
    sha256 cellar: :any, arm64_sonoma:  "0a1c713538535830169b7023a93e50af6014d9dab53a20e3ca6b3aa0b008f4ad"
    sha256 cellar: :any, sonoma:        "c6da1c55e3c44265cd48494357c2d4c4b5a2df636fbf3b4041284f87f081e0a9"
    sha256 cellar: :any, arm64_linux:   "381e390d57ff0924ad0c40ce12fc7bfa1ddac6c01e1f8ca2850267ff01a4feb1"
    sha256 cellar: :any, x86_64_linux:  "35ad57f50483863939fe0088ccff0c42539611dd60bc4488396f11fa6697974d"
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
