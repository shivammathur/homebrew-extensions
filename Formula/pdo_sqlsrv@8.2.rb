# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo_sqlsrv Extension
class PdoSqlsrvAT82 < AbstractPhpExtension
  init
  desc "pdo_sqlsrv PHP extension"
  homepage "https://github.com/Microsoft/msphpsql"
  url "https://pecl.php.net/get/pdo_sqlsrv-5.12.0.tgz"
  sha256 "22f0cb17b45f0deccd0bba072ee0085ff4094cd6ee2acc26f7f924975ef652c6"
  head "https://github.com/Microsoft/msphpsql.git", branch: "dev"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/pdo_sqlsrv/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia:  "ec86d9a2d1609fa8f4b90b806dbcb81ece5376946a2e2631d3b49430a4d0e1f4"
    sha256 cellar: :any,                 arm64_sonoma:   "b86ea72b0cb617b7708bb76143b4129262b1f3a0d4dee489107b58d63547b5fa"
    sha256 cellar: :any,                 arm64_ventura:  "b91b2cbe92161ae8bc3aad47566a4987cd8c71564f0959ec1eab9fa4d5594676"
    sha256 cellar: :any,                 arm64_monterey: "43db64c0a6d807882bc4da904bee5911839057f099fad53104fa909e14566bc4"
    sha256 cellar: :any,                 sonoma:         "a148c9d77607ed2b36e9cb229e9c66e43b82d63624fd25ac9465c0767b07362e"
    sha256 cellar: :any,                 ventura:        "a03019b9097b5e74a28f2b4e6e4ef80e3a77c3fdf555229d5deae4f175b4e27e"
    sha256 cellar: :any,                 monterey:       "93c892baf8d80892d15b01156e21dc2df83a3fead21359e07379db52c6ffcfb3"
    sha256 cellar: :any_skip_relocation, arm64_linux:    "bf47294af029fcfa95f50fc6922a1da0ca2ff283c1b9f01d84a346a2c3cc3e09"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "d1b66c53b713b831753d10721b728d728edd328e50de4ef2b0f68bfdd2173122"
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
