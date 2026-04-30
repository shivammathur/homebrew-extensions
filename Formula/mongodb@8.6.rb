# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT86 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-2.3.0.tgz"
  sha256 "7e7c4fbdc991bad24524316096d4ac9cd805632c9ba7f9886682db843d60166c"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v2.x"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "8e874253c4ef39b73976b8789908cab70ddd4dc3727e1bfc1916270a48cdf4ff"
    sha256 cellar: :any,                 arm64_sequoia: "9e914331d281d1782c0a7246cd7c4748f43a59436ca74c7de3b212551dddc6b9"
    sha256 cellar: :any,                 arm64_sonoma:  "0b3e590e64d50d795c839fcc1434753ede0ecf4e1331eaa65fa2fcc77d2f2f89"
    sha256 cellar: :any,                 sonoma:        "3aebe556f4a218cde2f940aa95a615979e67a1b575f908b0f349c22bfcee4080"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "63c5c7b65afe4911828fc37cee25b8f278c0807889338a86a3708094902022be"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "80caf959064b5099e4a34a826a50e0caa6a5404fa85b80887a97933d520a8234"
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
    Dir["src/**/*.{c,h}"].each do |f|
      next unless File.read(f).include?("XtOffsetOf")

      inreplace f, "XtOffsetOf", "offsetof"
    end
    inreplace "src/phongo_classes.h" do |s|
      s.sub!(/\A/, "#include <stddef.h>\n")
    end
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-mongodb"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
