# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT82 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.20.0.tgz"
  sha256 "01e87973fe7e54aac52054ec4a99cdd439ed5c01f7e5b8ea0a57031850d8e75a"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v1.x"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_sequoia: "e836edd961df02bb812e57fe476d9c2b85212e8f043c7b4aca448e7303900a3d"
    sha256 cellar: :any,                 arm64_sonoma:  "085ad332cac5b40fb7c0020ef54ce2176c54a3d167a84e5b3794b2ca35237063"
    sha256 cellar: :any,                 arm64_ventura: "912538c71c7479d2c9e598fe74b67635fe968cd2e6ab72d48e48964a4ea28645"
    sha256 cellar: :any,                 ventura:       "c52d2ce2f1630578e09735ed0c3528f03c9415b7d8480a36dc64b670219287a9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f9d388b0fe69de5e6fdde78853886fbf7de11cf15f1937f2e703a80bb87f8837"
  end

  depends_on "icu4c@76"
  depends_on "openssl@3"
  depends_on "snappy"
  depends_on "zlib"
  depends_on "zstd"

  def install
    # Work around to support `icu4c` 75, which needs C++17.
    ENV.append "CXX", "-std=c++17"
    ENV.libcxx if ENV.compiler == :clang
    Dir.chdir "mongodb-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-mongodb"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
