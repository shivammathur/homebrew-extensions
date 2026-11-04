# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT84 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-2.5.6.tgz"
  sha256 "05f0293fbaff1881ed2f25b227c324c3b778d3753e274a5d96e59c7e028b538a"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v2.x"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "10b3f9aadbd03b9fa481c196805f0e027ddae51fb9a7315e0032964490bcd57b"
    sha256 cellar: :any, arm64_tahoe:       "c4aaa8b946195f84c94277ee7a6372b6b4053ce423399d7fe5a075d1a38b8066"
    sha256 cellar: :any, arm64_sequoia:     "5cf86c95c5dccfbd62205fe202c37047b1f4320bdbf3bbdbd7540bf52d51408f"
    sha256 cellar: :any, arm64_linux:       "54a3df5ef881760d4841580d70e84750502ca596cf8d6ac89b566706b3dfa9db"
    sha256 cellar: :any, x86_64_linux:      "f4d021d0c0e1f9bf6a2684552e400d723150dd4ea1c91f0c5681a6777e7dd332"
  end

  depends_on "cyrus-sasl"
  depends_on "icu4c@78"
  depends_on "openssl@4"
  depends_on "snappy"
  depends_on "zlib"
  depends_on "zstd"

  patch do
    url "https://github.com/shivammathur/mongo-php-driver/commit/1e495320053a8be03e2fddf4bc3e23f28b1d1fac.patch?full_index=1"
    sha256 "1b290628c19666be809cd3df0cf532904cf89964c501ae816f2fcdd5266402a4"
    directory "mongodb-2.5.6"
  end

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
