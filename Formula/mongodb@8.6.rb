# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT86 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-2.3.2.tgz"
  sha256 "df01e7c41166fd068558977e390623061b3ef626e056b0fb4edb4d816021569c"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v2.x"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "b7523f3e1af18f49d80d6d8fb6997579c61fc7cc3024a3655d6f8cc6259f3e3d"
    sha256 cellar: :any,                 arm64_sequoia: "9719150057050fcfb45a54e28e642dc312da0762c4abc47277b9b869aa230b4b"
    sha256 cellar: :any,                 arm64_sonoma:  "ee5baa4b755511435471427e1023720e97e045e6aa1225876bc9cd51c7935f0d"
    sha256 cellar: :any,                 sonoma:        "f681b36d665f63e073088ecc968fdbeb7eae2d21b6f8ce0df963e64a8fd83f73"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "9830e0c9533efa2f827689e21f29b64499448463d27472077deca831588a1e32"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "9b8dc0bdbf2539884fcb4cf4ae69753f5619bc0ba02de2b63084a247606d6296"
  end

  depends_on "cyrus-sasl"
  depends_on "icu4c@78"
  depends_on "openssl@3"
  depends_on "snappy"
  depends_on "zlib"
  depends_on "zstd"

  def install
    # Work around to support `icu4c` 75, which needs C++17.
    ENV.append "CXX", "-std=c++17"
    ENV.libcxx if ENV.compiler == :clang
    Dir.chdir "mongodb-#{version}"
    server_api = "src/MongoDB/ServerApi.c"
    if File.read(server_api).include?("ZVAL_IS_NULL") || File.read(server_api).include?("zval_is_true")
      inreplace server_api do |s|
        s.gsub! "ZVAL_IS_NULL", "Z_ISNULL_P" if File.read(server_api).include?("ZVAL_IS_NULL")
        s.gsub! "zval_is_true", "zend_is_true" if File.read(server_api).include?("zval_is_true")
      end
    end
    if File.read("src/MongoDB/Cursor.c").include?("zval_dtor")
      inreplace "src/MongoDB/Cursor.c", "zval_dtor", "zval_ptr_dtor_nogc"
    end
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-mongodb"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
