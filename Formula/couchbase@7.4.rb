# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Couchbase Extension
class CouchbaseAT74 < AbstractPhpExtension
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
    sha256                               arm64_monterey: "d4407edcdc548f41fc05960b5f08248cdd37c403e4a80059d39f9abc499fddfe"
    sha256                               arm64_big_sur:  "1fc7baf9cbbb9ea34bc0132869cc4522c24af898d546ad19ae726037993817dd"
    sha256                               ventura:        "c87ea6cff68e5b355411422d30f6efaa482b21bcaa49bba2f4cdfc7ef87136bd"
    sha256                               monterey:       "5c0a759ad13fe8b3c20acfb282fe10541a32457aab07bd117a3dbc19aaaeb6a4"
    sha256                               big_sur:        "7c8a43c55ccc118b319a160151b7270b5dd3c55221cbe12b74fbd4d9bcdeecce"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "1077cf44baea7ae80e5b41b4bbe9a84cf3466f20ebc25d0f13e012b519712ca3"
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
