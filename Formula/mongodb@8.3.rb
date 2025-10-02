# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT83 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia: "ee90abe17d675cfefdc0f6782f8184610ae1d13f0b67d69f1cf71cdfa62c51ad"
    sha256 cellar: :any,                 arm64_sonoma:  "77a8db50dc610d2f110a2f7a91d2ea2a903e8188d97fcf709cd1d2511bc78365"
    sha256 cellar: :any,                 arm64_ventura: "4f2e4bbdc855c13cc0cbf424c7b5c92afce2535b580037a1e91a94915b8b36da"
    sha256 cellar: :any,                 ventura:       "3ad05dea7e4221d780f4c8942d04751bf2de9a0d09a63334f74b8e5a78ae0fc7"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "61ee77f49be3d8358b55b3b9f6bcf103a93db857b4bc7daf887b52a68daccf04"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c1ef0df7bb83ef4bbb33d1aaf9a9a850e8b819c18b2361d00f0db44001e30111"
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
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-mongodb"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
