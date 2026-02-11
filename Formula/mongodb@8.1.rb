# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT81 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-2.2.0.tgz"
  sha256 "02b0fc089176a1cc2133b5e12aba72bff103154d2ead4789749a99c1b47f8223"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v2.x"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "693a2a88845d3060380cb5c4b595347674a97147f14cd3aeadc2e65a0879e3ea"
    sha256 cellar: :any,                 arm64_sequoia: "7d6f895b4e5a1c119aa17923b4db80b7f3e9c36bb9e54684075a5aa239cde61f"
    sha256 cellar: :any,                 arm64_sonoma:  "35b96968206c72e3f1dacf837689139c251cd6d9484363564f3edae02746c21c"
    sha256 cellar: :any,                 sonoma:        "e7300ae61a2d69f186f97529190e0b66936d2c4442333dd7c518838dbdba76ed"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "ed70fe8d5e9ce4a4c154a07c743ec264400c70826632169ae6086452cd960dd0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "0e8efffce680c278cfafff8fb13f2ef492f5894bd9f41b8aeb4f9f370ec56959"
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
