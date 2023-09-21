# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT73 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.16.2.tgz"
  sha256 "d630cf32a73b6e5e05d2806782d35e06d24b7d5c83cfec08239549e6b6a600b2"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_ventura:  "7e5567a6f40907c2e611ec7a56cd3c68e3e4f0ddca4ada8f43c9e14956b1d879"
    sha256 cellar: :any,                 arm64_monterey: "80ce09f95c40f2e761423f147f28e62d3ab8754a7d8217bb75e82cc01a2514d4"
    sha256 cellar: :any,                 arm64_big_sur:  "e5d1f24d316bca36414e1fc9bb67f1522d4b2235cf353c79a6dc8d7ff56d547f"
    sha256 cellar: :any,                 ventura:        "83a878f68f62ac373e0ed2ee473116ee9f25276e7d80023383fbf6ccc790baff"
    sha256 cellar: :any,                 monterey:       "fe14b77b8f7fc8889e0a918300326acb05c3bf0a1a8d576709007703d2bca493"
    sha256 cellar: :any,                 big_sur:        "d41876414893b57001cb3b5a09be1acb8f49ca0e5f2ae57c3cd814a443072825"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "82bbbebcd371f370bf13a1ebfa62aaa33b46442afa478d7a6e481400534bb29b"
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
