# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT81 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_golden_gate: "acb38e9dcde2f96401bdf67982ffc61440e92a48c0e72b0ba82ef2c3be3338a9"
    sha256 cellar: :any, arm64_tahoe:       "14d051a852f2eecffc44be9c57987be2ff338e717a954bd353b13a784bd8f3ed"
    sha256 cellar: :any, arm64_sequoia:     "30e351b9faf5218601e3f02e7b6b4b73d86b5f1def44d68fa5c0fbb28cd6064d"
    sha256 cellar: :any, arm64_linux:       "4573d365acc119d07512536baf68c34e77bd6679d18a1f0c9d7a4c83b3544d84"
    sha256 cellar: :any, x86_64_linux:      "747729d0f8fdcf718371c26ab5b64fc38b9608cc1c4c00a0fd8238f0ef2810f4"
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
