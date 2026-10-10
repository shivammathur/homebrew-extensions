# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Couchbase Extension
class CouchbaseAT56 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_golden_gate: "b1bd506730a40d55bdede83f5cc121c47b3c380f87e5f12753ff691a9e7d5655"
    sha256 cellar: :any, arm64_tahoe:       "02b44d57569673b66cdcfbce84bfd643c45973149eb7e3e36cd49c7b6c4a6b6d"
    sha256 cellar: :any, arm64_sequoia:     "e73b94be3bd13d53dd00b9d1a5e067c468c102f22d438c8c6a617b57281dea55"
    sha256 cellar: :any, arm64_linux:       "be7d5a57db2f63aa8b0dd2579579799c5b5ec2f25e82a4cec4081bad8d1ff4e8"
    sha256 cellar: :any, x86_64_linux:      "519583c6a01c33b7211cb6374bc385753e7758ff42cf76c929d71323830ff0b2"
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
