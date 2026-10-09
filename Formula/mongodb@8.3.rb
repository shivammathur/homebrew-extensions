# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT83 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-2.5.4.tgz"
  sha256 "41eead0799cc66876b12d10b5efe86268bfc704c1be57a70d49e4bd4bf6c8ee1"
  revision 1
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v2.x"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "a8bf2721ae1e0691603b55439f786f8a52fd27c1f949b8aab45957ee64756a38"
    sha256 cellar: :any, arm64_tahoe:       "9fee9938ad22a0f92c743afc6af5b8a10f66c8fc638a5aca77b496d46cbf8146"
    sha256 cellar: :any, arm64_sequoia:     "6756a8b09a58bf0cdc8a8a86925c0ba536969a87cb008dcda347050312ad1d88"
    sha256 cellar: :any, arm64_linux:       "f0e9b5e2842df54038d46f26cb55f6d0d53c55874e90bacf7e86abb0192e88ce"
    sha256 cellar: :any, x86_64_linux:      "48e24d6d3ea78dde8abb85d85d3e361c99aeb05662228a7aa991b68e1c5eb0d5"
  end

  depends_on "cyrus-sasl"
  depends_on "icu4c@78"
  depends_on "openssl@4"
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
