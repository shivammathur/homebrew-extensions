# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT83 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-2.2.1.tgz"
  sha256 "b923617bec3cde420d80bf78aeb05002be3c0e930b93adaacaa5c2e0c25adb42"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v2.x"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "225b4f406e6ee9165c6dbd81d45aba3e6bfecf55a7a0771bbb9763e707803ce1"
    sha256 cellar: :any,                 arm64_sequoia: "cf50b8920b4965ac522fd1de25418387ea973367dc76ecd21f846923c751e973"
    sha256 cellar: :any,                 arm64_sonoma:  "8a5eb877c3c9fd40e87e68fb8b075cadd3c46a9759fa5468c06708f7cd30fbcf"
    sha256 cellar: :any,                 sonoma:        "880399b821ec442e5d5b0bf1054eebebbf1a1e5ee0ea130502d0702e0be51c5a"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "a871a847ed28cad1c193c3667f989f878896960bae8c68e787f18c3eca11dd76"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "743e26f0451ca18d3a4697cf3ae117cf2fa941bf751439ce6d2de8301c4154ff"
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
