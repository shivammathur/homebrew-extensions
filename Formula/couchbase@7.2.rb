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
  head "https://github.com/couchbase/php-couchbase.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_sequoia:  "b7b6b20f2ef2b1bd0e4ca92f348ce15b222a06ea8e1b5db51949b5451c983cfc"
    sha256 cellar: :any,                 arm64_ventura:  "295501d812e9e6538cb38616a7e834e7ae62edd0e7c3963eccd9d046ffe802e9"
    sha256 cellar: :any,                 arm64_monterey: "f5719cb4755c466f3ac11b289769160ae57f3afd400eddd83ee1740925dd33a8"
    sha256 cellar: :any,                 arm64_big_sur:  "7c37fc5facb2a1cfeea2acf05f2fbc2c8f58907346c4af76d96af6b283c5122d"
    sha256 cellar: :any,                 ventura:        "5e1e6e20348e62d5243dd13c4f1a1fd6ec5ce20dcffd79f995984765c1656aff"
    sha256 cellar: :any,                 monterey:       "3ba2e0eec774983371d9e1d5d50e7b4928b41e786f77196f12ef3263e3bc99a8"
    sha256 cellar: :any,                 big_sur:        "099102be6c86aefc55a97e238fb6b3bc442e1b4c7e312cbad239482ced272eef"
    sha256 cellar: :any,                 catalina:       "8d7ac9f94fc9d27770ceff5061ef59f770e6f8ec4b4d1719311a52283db5ad10"
    sha256 cellar: :any_skip_relocation, arm64_linux:    "496438415b86309ae30a6ec7fef4a9f09baba4c8c97bd2bae1fc340b5c492fad"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "3ac84a11c8f974b4a257bfddb71d9b4818505bd1cf6b83ab3d567a54ebeb0dbf"
  end

  depends_on "libcouchbase"
  depends_on "zlib"

  def install
    Dir.chdir "couchbase-#{version}"
    safe_phpize
    system "./configure",
           "--prefix=#{prefix}", \
           phpconfig,
           "--with-couchbase=#{Formula["libcouchbase"].opt_prefix}"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
