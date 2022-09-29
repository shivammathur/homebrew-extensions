# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT83 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.14.1.tgz"
  sha256 "bae2a876fdcc13d6cd0139fb5b2aefd51c9d5c84a6a4fc53bebdbe3f162d835e"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "4ba6b23282701c89e19d28e8fc6e07a14805cf28137bd7c9ac027149e75c85e3"
    sha256 cellar: :any,                 arm64_big_sur:  "bfa423853507b63983db0dbb64a9d409d50fce31d129c5235ba020eef9e01340"
    sha256 cellar: :any,                 monterey:       "834aeed8cedc6b46db144436a8b12b1f60f6825f3a2036baf2b2f5170fac8f98"
    sha256 cellar: :any,                 big_sur:        "d46181d28ba1bbe20afb23230932460aff32880dbabf929cd739590c28c77787"
    sha256 cellar: :any,                 catalina:       "fc10fe7351d4c830bb5afd34ba8be91e10a419a3f0ecf9ea29ed66c4ebc270e5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "dd60e1fdd83fd032cec5c09e28c863bfb196b1515ca09be61477692dcc28950f"
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
