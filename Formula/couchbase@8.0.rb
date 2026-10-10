# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Couchbase Extension
class CouchbaseAT80 < AbstractPhpExtension
  init
  desc "Couchbase PHP extension"
  homepage "https://github.com/couchbase/couchbase-php-client"
  url "https://pecl.php.net/get/couchbase-4.2.5.tgz"
  sha256 "5b5d830ce2eadb551a251070082b910ccaedd9fab9dc5c554a0bd98b7e50ca5f"
  revision 1
  head "https://github.com/couchbase/couchbase-php-client.git", branch: "main"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "aba96f3250509685db33dd61e803fb437e030d0ad3cb0b83e6537951aaff4f52"
    sha256 cellar: :any, arm64_tahoe:       "4a25eea856e055493e2df51eff28f2010412e82c5f7ba7e270994e35be498213"
    sha256 cellar: :any, arm64_sequoia:     "2093cb21d23183fe29a2fa328df6f40567c1a4bc8f5654e8dadaabaa1a350385"
    sha256 cellar: :any, arm64_linux:       "a7f35a108e68d99e1b03cd3c7398180090ddcc13ad23c39aee36aafd05c995fa"
    sha256 cellar: :any, x86_64_linux:      "acd6519387aa74333b65ce8e266f12a5fd09faa939954cca4e8686502dd1b3b6"
  end

  depends_on "cmake" => :build
  depends_on "openssl@4"
  depends_on "zlib"

  on_linux do
    depends_on "gcc" # C++17
  end

  fails_with gcc: "7"

  def install
    ENV["OPENSSL_ROOT_DIR"] = Utils::Path.formula_opt_prefix("openssl@4").to_s
    Dir.chdir "couchbase-#{version}"
    safe_phpize
    inreplace "configure",
              "EXTENSION_DIR=`$PHP_CONFIG --extension-dir 2>/dev/null`",
              "EXTENSION_DIR=#{prefix}"
    inreplace "Makefile.frag",
              '-DCMAKE_C_COMPILER="$(CC)"',
              '-DCMAKE_C_COMPILER="$(firstword $(CC))" -DCMAKE_POLICY_VERSION_MINIMUM=3.5'
    inreplace "Makefile.frag", '-DCMAKE_C_FLAGS="$(COMMON_FLAGS)"',
              '-DCMAKE_C_FLAGS="$(filter-out $(firstword $(CC)),$(CC)) $(COMMON_FLAGS)"'
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-couchbase"
    system "make"
    system "make", "phpincludedir=#{include}/php", "install"
    write_config_file
  end
end
