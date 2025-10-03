# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT86 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-2.1.2.tgz"
  sha256 "01892642ba68f762b5a646f7e830d693e163a32b7e78c16e616df72c56ce3d2d"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v2.x"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_tahoe:   "bbee5a519fd680775a32df34e967e4b48aee6a677e4329a8afbf58303766a021"
    sha256 cellar: :any,                 arm64_sequoia: "5692953472716001f06e9eb54e301eeaabd7d1cc098bb181136e4594cbe01a6a"
    sha256 cellar: :any,                 arm64_sonoma:  "588497b8faa1aeddbee734be7a724d7257cc0641b03fba45f905f1190af6cb92"
    sha256 cellar: :any,                 sonoma:        "7f4827563b0d8d7a06fb0b9aa4404fdb8f9f22b0865fbf9a49cfe81b9069363e"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "b920f8ac8ba1a9d14f7e7fbd9b760b71d9f7634216fe31150e920537b11dcbf0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "efab898093831647f70de4440f06ee2fd872518d516f6ed31205b7006db65442"
  end

  depends_on "cyrus-sasl"
  depends_on "icu4c@77"
  depends_on "openssl@3"
  depends_on "snappy"
  depends_on "zlib"
  depends_on "zstd"

  def install
    # Work around to support `icu4c` 75, which needs C++17.
    ENV.append "CXX", "-std=c++17"
    ENV.libcxx if ENV.compiler == :clang
    Dir.chdir "mongodb-#{version}"
    inreplace "src/MongoDB/ServerApi.c", "ZVAL_IS_NULL", "Z_ISNULL_P"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-mongodb"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
