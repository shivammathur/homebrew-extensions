# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT85 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-2.1.1.tgz"
  sha256 "bea8eb86be7e301b1cd3935ee3ccfa052e410a7cfa404ae5ab4b11e4c99b8899"
  revision 1
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v2.x"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "d223743dc3be4a190bd35e5dc3ee14ee12a7e00a9a51e1eaaa9729ef342a19fb"
    sha256 cellar: :any,                 arm64_sequoia: "6f68cc99d15c51218d7488f8815473c2fe6a2b52d3cca7407ef9f025f06c53f6"
    sha256 cellar: :any,                 arm64_sonoma:  "8831736b4018e808390bd31db6185abadc2248589819f8b1485972fd5c8444b6"
    sha256 cellar: :any,                 sonoma:        "f6328dee6abc00ab10d236faad89c6c4fbc8aff8fa8bb2d073c950e143dfe66d"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "249eb2aab0c5b2fac0e25ab8bb7c4283ae2eac0830bbd8bd86a029e8d799b10d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "aa7e3923885c82392162a1c3a6cba97cdc2e0afb95940f664b9dce282cf0a46a"
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
    inreplace "src/contrib/php_array_api.h", "IS_INTERNED", "ZSTR_IS_INTERNED"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-mongodb"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
