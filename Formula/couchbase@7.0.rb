# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Couchbase Extension
class CouchbaseAT70 < AbstractPhpExtension
  init
  desc "Couchbase PHP extension"
  homepage "https://github.com/couchbase/php-couchbase"
  url "https://pecl.php.net/get/couchbase-2.6.2.tgz"
  sha256 "4f4c1a84edd05891925d7990e8425c00c064f8012ef711a1a7e222df9ad14252"
  revision 1
  head "https://github.com/couchbase/php-couchbase.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "78c2e74578e08e53f00e5cdd8b94e5f54da519050cde3b49dfefa999a1b19102"
    sha256 cellar: :any, arm64_tahoe:       "2b0f97ffe20ab3b4a7e79dc37fc413d21ae62423fb5bfffc22fa58779942837a"
    sha256 cellar: :any, arm64_sequoia:     "758694e7d624bb0e3998087c51acaf5443b84f62220bcb5dc86075c489b1f46f"
    sha256 cellar: :any, arm64_linux:       "243e76cdf681f6ccbf93c10797e23e527b1920110ffc61cf3c08294568e93d7d"
    sha256 cellar: :any, x86_64_linux:      "412a41552156e2ad219a50c2180c491392a64d590e09b05084b1a6e111ba074c"
  end

  depends_on "shivammathur/extensions/libcouchbase@2"
  depends_on "zlib"

  def install
    Dir.chdir "couchbase-#{version}"
    safe_phpize
    system "./configure",
           "--prefix=#{prefix}",
           phpconfig,
           "--with-couchbase=#{Utils::Path.formula_opt_prefix("libcouchbase@2")}"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
