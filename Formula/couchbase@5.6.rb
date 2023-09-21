# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Couchbase Extension
class CouchbaseAT56 < AbstractPhpExtension
  init
  desc "Couchbase PHP extension"
  homepage "https://github.com/couchbase/php-couchbase"
  url "https://pecl.php.net/get/couchbase-2.6.2.tgz"
  sha256 "4f4c1a84edd05891925d7990e8425c00c064f8012ef711a1a7e222df9ad14252"
  head "https://github.com/couchbase/php-couchbase.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_ventura:  "53812b94d2d4d3428b6664c660e7efea120e72b270cbecd22f2ab22a1fd56d17"
    sha256 cellar: :any,                 arm64_monterey: "7d31fdb0939fd7a40da327673f9303ac776b356f3491d65a4231712bd1ba581b"
    sha256 cellar: :any,                 arm64_big_sur:  "adf794bb8c37455c5e065af50a5dd11b9df304b2ce2e0ebfe933c93237471856"
    sha256 cellar: :any,                 ventura:        "eb45482f5142685b80c285dfe171c2df733a42ee28d50b9ca0e103be6bda22d3"
    sha256 cellar: :any,                 monterey:       "55c096a7617b023d6fbe8015c6325d9ac5bd0765c11f8433eaf42855744d5e73"
    sha256 cellar: :any,                 big_sur:        "94deb13d7d68c6bcd3a26b32df282cf198f5e3481863c74a80c05aad9437b2ca"
    sha256 cellar: :any,                 catalina:       "62259ee50487083700422d5b08f6c5c27fc1327b8feed6a68615f20a7a8e09fa"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "fa11450b668fc666cadacaa75003fb4d02a77888409ceedbc3d9782b7e2d6ba2"
  end

  depends_on "libcouchbase@2"
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
