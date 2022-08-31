# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Couchbase Extension
class CouchbaseAT83 < AbstractPhpExtension
  init
  desc "Couchbase PHP extension"
  homepage "https://github.com/couchbase/couchbase-php-client"
  url "https://pecl.php.net/get/couchbase-4.0.0.tgz"
  sha256 "caa67e972a8e0f50b920088434eea14671902f253fb5bfb854b7e8d3898bcd26"
  head "https://github.com/couchbase/couchbase-php-client.git", branch: "main"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_monterey: "5b082602abd643208db4356dfe305ff23e637a9dcd18b3e68da0f4d3f2f7f9e9"
    sha256 cellar: :any, arm64_big_sur:  "213d2881e756b7cd15d0fd4a1001320cb12c74a5ca7080dda4e9a071eff52453"
    sha256 cellar: :any, monterey:       "9371a3d606fbd627255e3593a88947c86807ebc92e2e98f4c4bac880ad79a542"
    sha256 cellar: :any, big_sur:        "e69df7ea612d6317eb257e62992404fbfc8431391e699b85c8a488e0e2745b5f"
    sha256 cellar: :any, catalina:       "5e2311e5ba5b2e6cb1be3841d3e6744355418093860caef4188a207223c4d12d"
    sha256               x86_64_linux:   "6ee756985698216722d246d004bec66c05fb7ed1e720905a8c79f33a539bc66d"
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
