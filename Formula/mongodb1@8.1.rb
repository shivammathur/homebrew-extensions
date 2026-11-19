# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class Mongodb1AT81 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.21.14.tgz"
  sha256 "4d918b07ebf3bf2c237fecb70c13170c282fca5df627fb0b7d3260b003f46495"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v1.21"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(1\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "be77a440c2fa974277e74c2372ba7d044abe14ef95481989755ab1a9465d068c"
    sha256 cellar: :any, arm64_tahoe:       "69f7dda46784482b1d46f32112ea26aba99c77c2f44d131515d6a467034835eb"
    sha256 cellar: :any, arm64_sequoia:     "01ed624c141e4d1d8dfbe6cc292da2992ee14862ebcac1bef7b3979f1029b581"
    sha256 cellar: :any, arm64_linux:       "2cab00a59fe96fdad3cfa201609179e4764df95c098e29dcd256d6cf5f93408e"
    sha256 cellar: :any, x86_64_linux:      "6c3f9059edd1eefd4d85e83e82ab629e5c890565bd90b89933dc8fedc47d86dc"
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
