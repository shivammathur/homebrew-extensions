# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Couchbase Extension
class CouchbaseAT71 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_golden_gate: "038a0c4e9b557b766d0b0501eb3752db549579df8b77d78446fa4d101898aeba"
    sha256 cellar: :any, arm64_tahoe:       "7cfe84dceb974a80a84d3f456dd1e2496e6c8d9b02c8be73eb0c0981030e0d95"
    sha256 cellar: :any, arm64_sequoia:     "25529509c1f4fe717de7240cc24e5296f01d0ad70330d041b624b214cfbe2589"
    sha256 cellar: :any, arm64_linux:       "0577efb729e74f4114d7e424d9e38180b4a12f6eb168667db6179d475223ee3f"
    sha256 cellar: :any, x86_64_linux:      "93135c069003cfb6c6f5af98d0662432f5d1c002ef69119b3fb81f98996ed926"
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
