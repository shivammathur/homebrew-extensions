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
  head "https://github.com/couchbase/php-couchbase.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_ventura:  "104d25e08f2afa8abff13670b0dff290462554e52132237c0684ff98e4e4c4af"
    sha256 cellar: :any,                 arm64_monterey: "b92fccf009a9e81610c48d9d25df6dfe86429fae8edc1dd9109b4b0e3b91bf45"
    sha256 cellar: :any,                 arm64_big_sur:  "21fd44698c1180c74082751c53ad6ad7962e548e539b45f6aa6ef96a1d79162d"
    sha256 cellar: :any,                 ventura:        "594a5a68557b80fc435f91570114a2d371e44eab82bdbbb4f9710c05f25b220f"
    sha256 cellar: :any,                 monterey:       "aa5851359e2f0fce2f73b3071d49285206d5804e95a7cf402f209665eb78a078"
    sha256 cellar: :any,                 big_sur:        "163d94b0b74f6dc04a1004ebfda3265a633464821e5b9e410e9aca38995bff91"
    sha256 cellar: :any,                 catalina:       "c912fcb80d415c0dd984ddccbf0b6254c9f7c4bd9e0122efde576c07baa1d4a6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "87f4a26848d822cc47a1b68e11006b2709a9261387d0fea228b869e342e3ba80"
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
