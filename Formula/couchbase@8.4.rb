# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Couchbase Extension
class CouchbaseAT84 < AbstractPhpExtension
  init
  desc "Couchbase PHP extension"
  homepage "https://github.com/couchbase/couchbase-php-client"
  url "https://pecl.php.net/get/couchbase-4.2.5.tgz"
  sha256 "5b5d830ce2eadb551a251070082b910ccaedd9fab9dc5c554a0bd98b7e50ca5f"
  head "https://github.com/couchbase/couchbase-php-client.git", branch: "main"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "fb53b95c3f3b7ba5d02a4a68b42cd992c533a832f98849f555da0218fc87e8c5"
    sha256 cellar: :any,                 arm64_sonoma:  "a8a61a369fcdaf369b2a647a7a94f8c3da8a9296cc5b9d087420f5fa1997856d"
    sha256 cellar: :any,                 arm64_ventura: "51495bb216ba5d926d03323f7e365d45fc6acfd1795e41fc84196d1e2ad7eb68"
    sha256 cellar: :any,                 ventura:       "7b6504550052ada263456f568281ec515d4a37858207a803c4e8a0fa1ecb7c5c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a3133d77c2dfb812918fef1382eb4cb1e8f950f485e9fca9669da5d4de41dd6a"
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
    ENV["CURL_SSL_BACKEND"] = "SecureTransport"
    Dir.chdir "couchbase-#{version}"
    safe_phpize
    inreplace "configure",
      "EXTENSION_DIR=$($PHP_CONFIG --extension-dir 2>/dev/null)",
      "EXTENSION_DIR=#{prefix}"
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-couchbase"
    system "make"
    system "make", "phpincludedir=#{include}/php", "install"
    write_config_file
  end
end
