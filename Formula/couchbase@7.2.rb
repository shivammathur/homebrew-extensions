# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Couchbase Extension
class CouchbaseAT72 < AbstractPhpExtension
  init
  desc "Couchbase PHP extension"
  homepage "https://github.com/couchbase/php-couchbase"
  url "https://pecl.php.net/get/couchbase-3.0.4.tgz"
  sha256 "f9536473a4bc113ee5712ea0d4c1bd9b26a51662ca14a8490de7293181662f47"
  revision 1
  head "https://github.com/couchbase/php-couchbase.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "2036eb9e66b36452187b479ef2a257e76cbaa06ad369b0cfe31f993c7580066a"
    sha256 cellar: :any, arm64_tahoe:       "bafacdaffa9a4ecc00be2c74a9bd00fde0cc947f088477929520f769105cab20"
    sha256 cellar: :any, arm64_sequoia:     "f2807327cd3966d919f0182cec31e86db2a73514d4a1c4e2f65f8efb46e94c9e"
    sha256 cellar: :any, arm64_linux:       "9e8a32755799361943cf92f41a27473afc78883a89d2b9fcf4e7930c94b07f2f"
    sha256 cellar: :any, x86_64_linux:      "e4267d0c52d37f0629f8eb7f5c7d9f9f4ea5613c2f589801a6e18549137a80dd"
  end

  depends_on "libcouchbase"
  depends_on "zlib"

  def install
    Dir.chdir "couchbase-#{version}"
    safe_phpize
    system "./configure",
           "--prefix=#{prefix}",
           phpconfig,
           "--with-couchbase=#{Utils::Path.formula_opt_prefix("libcouchbase")}"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
