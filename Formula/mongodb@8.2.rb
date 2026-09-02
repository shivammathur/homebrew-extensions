# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT82 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-2.5.0.tgz"
  sha256 "532b8408978a3b7a0aa4abdd7b33699ccbf94c312e7fce38da408b787006c08f"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v2.x"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "0fd6f0b0df317f547b19398eb48f25c35cad97d966790ea459d7e0e53edb9899"
    sha256 cellar: :any, arm64_sequoia: "3c1fdf6fd572de5b02707ef73383807a60e357b612635ca4906f0e2ab94c1219"
    sha256 cellar: :any, arm64_sonoma:  "ad3368515ac5175baedcc22ab43454edb833a85e30e58bf21f5e2d6171d2a744"
    sha256 cellar: :any, sonoma:        "ebb823fcd665bf078d110e5bde298d3864fc00ae69192988a76867242d08e5b3"
    sha256 cellar: :any, arm64_linux:   "faec0d8330a5075302daee885941857e7c5d48cf9ca135043d75647b2f0750c2"
    sha256 cellar: :any, x86_64_linux:  "1a35810b76811e9b032c3f4905619ac84f74396cc24d5d8f1a3ba41644e6eae6"
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
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-mongodb"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
