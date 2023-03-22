# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Couchbase Extension
class CouchbaseAT74 < AbstractPhpExtension
  init
  desc "Couchbase PHP extension"
  homepage "https://github.com/couchbase/couchbase-php-client"
  url "https://pecl.php.net/get/couchbase-4.1.2.tgz"
  sha256 "c5d3109365a47a785ad21713a27cbb3da7205da506bc7bf255ea04fc14d835e2"
  head "https://github.com/couchbase/couchbase-php-client.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "d6c2e8b98ac13a02dd4f66f838f7df46c6f885ca43c818b1233c77f92fe5305e"
    sha256 cellar: :any,                 arm64_big_sur:  "3fd757d517415af80d9cfd3d43665ed2a92c861d5959a9175864b7610167e3b6"
    sha256 cellar: :any,                 monterey:       "dffd3b655e87d9725ec6844462b77c62199b547d4e22611be1daac9fbf2599dd"
    sha256 cellar: :any,                 big_sur:        "085732b364a5c12d5513d47665c7d18260ff81ed6ea67515e70bb0304efb5c5f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "5ef75d9a0345287582eb6202b33c1e34db9bc7717495960cc4e0efda5a674e9c"
  end

  depends_on "cmake" => :build
  depends_on "openssl@1.1"
  depends_on "zlib"

  on_linux do
    depends_on "gcc" # C++17
  end

  fails_with gcc: "7"

  def install
    ENV["OPENSSL_ROOT_DIR"] = "#{Formula["openssl@1.1"]}.opt_prefix"
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
