# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class Mongodb1AT82 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.21.15.tgz"
  sha256 "97772e6a0f2019eff7856522464e4432984f4fec470eaae14b807d70809b477c"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v1.21"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(1\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    manifest_sha256 "2fea24c95b4a2114ee0b944984de22c59ed743f9b407dc5df3e9678c324af569"
    sha256 cellar: :any, arm64_golden_gate: "faf440f5f721f25387eef1190f46ce89fedb6cdcdf8c701f5089439099881c23"
    sha256 cellar: :any, arm64_tahoe:       "b67a999c8b6507c917772fb46a49a5077f4115cf2de0a02a167b8488aafed9e2"
    sha256 cellar: :any, arm64_sequoia:     "179fc776871187d20f8a29ea572cea9130d7d6963aa7c63ab12bb5e9fe0d1610"
    sha256 cellar: :any, arm64_linux:       "3058fac4b268b5983a09fe073a870413a776f331cdb725651bc02e7fab102e54"
    sha256 cellar: :any, x86_64_linux:      "7157a284b2b04ea23425a61a19d776d8836d7b2640c3c4615d0a4ccf2f999eca"
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
    prefix.install "modules/mongodb.so"
    write_config_file
    add_include_files
  end
end
