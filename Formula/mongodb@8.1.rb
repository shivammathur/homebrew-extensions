# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT81 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.16.2.tgz"
  sha256 "d630cf32a73b6e5e05d2806782d35e06d24b7d5c83cfec08239549e6b6a600b2"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "585ee4e5dbaa5110bbf6a49b68976466a56daa44b0cfbb99aeff48efe83f52fe"
    sha256 cellar: :any,                 arm64_big_sur:  "9875a185045360360b38447a7a58b574601078622c8070628bf355abb46c5069"
    sha256 cellar: :any,                 ventura:        "589656cfd576c0d8dfffd17ff2b6c8082db7cd60d2a47be48a7c2bdf97c3e907"
    sha256 cellar: :any,                 monterey:       "16be9727ff1c57f96033cd5c7565945213d4ab2ee61af415f6a8a19fd90ee08c"
    sha256 cellar: :any,                 big_sur:        "daaa90239fef81293b801e9b0c1a180bf06c84513e81f34703a1da9c9845a41b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "348669b73f027e3c9f8aab61ac7687d285c9d2aa6950ca975206064ebc1b32bf"
  end

  depends_on "icu4c"
  depends_on "openssl@3"
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
