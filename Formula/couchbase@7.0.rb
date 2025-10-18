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
  head "https://github.com/couchbase/php-couchbase.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_sequoia:  "2ed18810d8c8c1814562f6ce78eaa72424ce74ec71a6942440ec47c4b794325f"
    sha256 cellar: :any,                 arm64_sonoma:   "cab004f3a909357ca70fa405df0ae67a28efa1bca6db53cab8f6d582851c0dba"
    sha256 cellar: :any,                 arm64_ventura:  "c01b32c9c17eb11488512011ad6859b14e4d1e3d77e93ac7c9afa7aad37f627c"
    sha256 cellar: :any,                 arm64_monterey: "e232f584620c0e2934903bf89399f8a57b670a7e88490aa14a33f288a23e5735"
    sha256 cellar: :any,                 sonoma:         "89c039302f61f3833d914fbf830781151267290c3578fdf3336408fcd5c70139"
    sha256 cellar: :any,                 ventura:        "2ab39f16e258b1fce97fcf7ade87ba31737a65988109f6ffa089cfdc475d616d"
    sha256 cellar: :any,                 monterey:       "77faae50659e73b595b05670a51a9dc3e32e5a0f1e0f1f0491698d19e216f6b5"
    sha256 cellar: :any_skip_relocation, arm64_linux:    "30081fa006d5ff20797a9f37b4f041e4abacd7a096ced47e069e96ecf19469af"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "3b154e2bca7a105d35f8dd882a44f9f271bc1d733c883181776d8cb817b14336"
  end

  depends_on "shivammathur/extensions/libcouchbase@2"
  depends_on "zlib"

  def install
    Dir.chdir "couchbase-#{version}"
    safe_phpize
    system "./configure",
           "--prefix=#{prefix}", \
           phpconfig,
           "--with-couchbase=#{Formula["libcouchbase@2"].opt_prefix}"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
