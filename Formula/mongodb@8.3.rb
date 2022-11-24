# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT83 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.15.0.tgz"
  sha256 "eeb6268d34bd0b4a3dcc60dde4e484f5cf4fa2439ca3d9f024c0000e99ee7240"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "032cdf11570379a9cb484d4d86ca1de39329651a66f9f385f9957da7dee6eae8"
    sha256 cellar: :any,                 arm64_big_sur:  "e795c1b1c455fa2a7db7a53a047221f263f59691e6e81dcb6b984a0e2fd5b8c3"
    sha256 cellar: :any,                 monterey:       "86e91964526f09708b9cee0a6a7bd443b9196d918316ef5398c912c4738066a9"
    sha256 cellar: :any,                 big_sur:        "15ca375cfdd4eeeac09ffeefb4d2efc7ddcea6068744d6a54a6c8cb2346afd86"
    sha256 cellar: :any,                 catalina:       "a7595051a3c5eda554adf53c71011a30bb16fa49ed8df130b3760a6f74d56153"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "15c124abd448239bd93452ac168a61a86c2c279a614e2f856f87bd56ea7478f0"
  end

  depends_on "icu4c"
  depends_on "openssl@1.1"
  depends_on "snappy"
  depends_on "zlib"
  depends_on "zstd"

  def install
    Dir.chdir "mongodb-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-mongodb"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
