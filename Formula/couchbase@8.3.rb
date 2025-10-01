# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Couchbase Extension
class CouchbaseAT83 < AbstractPhpExtension
  init
  desc "Couchbase PHP extension"
  homepage "https://github.com/couchbase/couchbase-php-client"
  url "https://pecl.php.net/get/couchbase-4.4.0.tgz"
  sha256 "328d57e1054a3f073d5ed2c29507871c0fcc5e0c9398e7f1d8227833c054e689"
  head "https://github.com/couchbase/couchbase-php-client.git", branch: "main"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/couchbase/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "ff712a89570e2695d7d0da5335b83d555e2ceba0b4a8fe0cb748b0c04f0c7def"
    sha256 cellar: :any,                 arm64_sequoia: "27cb4bd63216d2bb7dd8d9a0b7b246503e27236cf2cb53f3eea8fbff8f762209"
    sha256 cellar: :any,                 arm64_sonoma:  "3600a0a77ea0bf510f61e7c1897987270b9c34a04e425b3d8c32dc485e145970"
    sha256 cellar: :any,                 sonoma:        "4012b30e407a56ed8dae11c36ea482dd973e08564ce8b8c4c6e0a68c6127cb34"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "a763651ff5c36649a1c8f717bc9a71dc344cfbf41eef4fb1da0be68012348d72"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "041fa2a5520a6c65a6de57c69510ce28e09a14b8c84d8233c3fb7c51acefe42d"
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
    inreplace "Makefile.frag",
     '-DCMAKE_C_COMPILER="$(CC)"',
     '-DCMAKE_C_COMPILER="$(CC)" -DCMAKE_POLICY_VERSION_MINIMUM=3.5'
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-couchbase"
    system "make"
    system "make", "phpincludedir=#{include}/php", "install"
    write_config_file
  end
end
