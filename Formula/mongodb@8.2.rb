# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT82 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.15.0.tgz"
  sha256 "eeb6268d34bd0b4a3dcc60dde4e484f5cf4fa2439ca3d9f024c0000e99ee7240"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "06fbdb4a031f895cef03cdd5b4502ecb489d11d62578616c0bde872d141e4edf"
    sha256 cellar: :any,                 arm64_big_sur:  "df3f54be234137dc760e93fe7ebaebed0a6514805169c57757ff435191c45889"
    sha256 cellar: :any,                 monterey:       "3f868b51cb07c72fb7898451f7c1b2383a9ec2e1f371277c208146788b20eae8"
    sha256 cellar: :any,                 big_sur:        "5ed4a6a8154b86c4b762cd14d9ec68edd34b48d1e2e08d522f33dba4466ea1b6"
    sha256 cellar: :any,                 catalina:       "df317af6456399b6333457e58f470566c8d5e60807b2d06f9f7d61f12632df89"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "0bff0b87b1a10e89e19b20e1c3adddb04aff3ef2614519f821aeadea7c6febb3"
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
