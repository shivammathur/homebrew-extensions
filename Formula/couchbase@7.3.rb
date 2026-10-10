# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Couchbase Extension
class CouchbaseAT73 < AbstractPhpExtension
  init
  desc "Couchbase PHP extension"
  homepage "https://github.com/couchbase/php-couchbase"
  url "https://pecl.php.net/get/couchbase-3.2.2.tgz"
  sha256 "d8bd785ccce818e0beb9694cd02ab01ed26e0cf9b19217d2bc2e92b38b21c9c1"
  revision 1
  head "https://github.com/couchbase/php-couchbase.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "9fc7e15c06f7b6d322013121c8987129208179a6ad62f60cc0dcf9db2bb82456"
    sha256 cellar: :any, arm64_tahoe:       "c98f4f1c9d7d415623f424b44a74d0dfff5e663661cf8386a0277337f5ffa2e6"
    sha256 cellar: :any, arm64_sequoia:     "87940feeb7dfdda5770df3f5f991dde21f5ba30b6de3f3b3182309de5215f2e7"
    sha256 cellar: :any, arm64_linux:       "fd868357560f91af48c4d830f4dbf98560155b56dfca7ca2444d8016b77db204"
    sha256 cellar: :any, x86_64_linux:      "a7460b5b707c4e62fd8ec836624d7d5010f2808244072289a6c0564372bb4abc"
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
