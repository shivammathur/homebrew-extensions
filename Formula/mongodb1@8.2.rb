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
    sha256 cellar: :any, arm64_golden_gate: "759da46d7daa63d7683698194412edb14659df98a417caa82e1723de38ee1a64"
    sha256 cellar: :any, arm64_tahoe:       "195fff36e385fdb2fc5dee1f1a24191c6af9154386c04f2d92d2404422d97a5f"
    sha256 cellar: :any, arm64_sequoia:     "b7df1073304c86e4b9f08798bd60a83480adc1f9e365a9b303c905742246ff4f"
    sha256 cellar: :any, arm64_linux:       "c094b48bce7bd48a30f1b215ab2438cc3c5cb29dc53a48cf1a62c236ae3154b0"
    sha256 cellar: :any, x86_64_linux:      "23e9189aebb13bb4efa7e52b5a34c435f30332a28d2f5a6f6df35d203a8640f0"
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
