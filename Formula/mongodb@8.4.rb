# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT84 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-2.5.9.tgz"
  sha256 "9ecf4f6005e1adbb0e5c59c55ff2e9c8347983060aac472043ee3b8570e816f3"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v2.x"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    manifest_sha256 "63e2a60821a06447bebaadbb3f0016b35d93bb34ca5e7f159923d9e81af938df"
    sha256 cellar: :any, arm64_golden_gate: "6025fba6894f2a5b988ab02e6ab684f625c1f46ac9a9456edf4c4cc75333e3f9"
    sha256 cellar: :any, arm64_tahoe:       "23bcaea85245552127d22ec16692a6d8442171a83f8d5f4f4276b52686c0ca03"
    sha256 cellar: :any, arm64_sequoia:     "dc2f175d7de4d89d8be7e58ca898e42cc11967dbc907a5727ef5363933ccc5f7"
    sha256 cellar: :any, arm64_linux:       "dd7c60bb7bc2495a3018f5391c89877e0d99222e89fa5ecdc7cd6a45891b17af"
    sha256 cellar: :any, x86_64_linux:      "9843da18a95aeba2a97eb3faf74e971ea02bc3bca135526aeefda7d990097606"
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
