# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Couchbase Extension
class CouchbaseAT80 < AbstractPhpExtension
  init
  desc "Couchbase PHP extension"
  homepage "https://github.com/couchbase/couchbase-php-client"
  url "https://pecl.php.net/get/couchbase-4.1.4.tgz"
  sha256 "80ba7dbabb7f7a275907507186ecb27b559e64082a22ba1ad39cdd129d383ce5"
  revision 1
  head "https://github.com/couchbase/couchbase-php-client.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256                               arm64_monterey: "45ac78fea139074d0ad7cfdbd474939135c6343445b6dca22033eba38150baf3"
    sha256                               arm64_big_sur:  "191dc966cfe6148a96bc5dc4034ba3c2cd0390162b6eb758689f371bd9e354d3"
    sha256                               ventura:        "019c5546449ba346515b97ee04558fd23c301c64a3a9db6121e03ee37f6e351c"
    sha256                               monterey:       "f7542f0b209be36b775ded7248b07e9b0494375a7b1ef847451625d37b1ce53d"
    sha256                               big_sur:        "04139c0e7b97228b5e151dad1ef052bc0b144f819144c54a619db24db0db1f3a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "11b83154b2c3d10fd3743e6fd6d0938780e174f53c1a854f7fd9c0df5f951101"
  end

  depends_on "cmake" => :build
  depends_on "openssl@3"
  depends_on "zlib"

  on_linux do
    depends_on "gcc" # C++17
  end

  fails_with gcc: "7"

  def install
    ENV["OPENSSL_ROOT_DIR"] = "#{Formula["openssl@3"]}.opt_prefix"
    Dir.chdir "couchbase-#{version}"
    safe_phpize
    inreplace "configure",
      "EXTENSION_DIR=`$PHP_CONFIG --extension-dir 2>/dev/null`",
      "EXTENSION_DIR=#{prefix}"
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-couchbase"
    system "make"
    system "make", "phpincludedir=#{include}/php", "install"
    write_config_file
  end
end
