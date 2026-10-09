# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT84 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-2.5.4.tgz"
  sha256 "41eead0799cc66876b12d10b5efe86268bfc704c1be57a70d49e4bd4bf6c8ee1"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v2.x"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "bb96571b07d7b30eb554c187fda9b9d4b25f00c298aee25665542547ed83e8bd"
    sha256 cellar: :any, arm64_tahoe:       "025eacc9df959467ba03742e9dd4dec46ece83aa153f3d2ef0cb75a14d93105a"
    sha256 cellar: :any, arm64_sequoia:     "f16fbae9270914afb12c8d64a23d735b056a7c3239a67d5ff8ec5846556df944"
    sha256 cellar: :any, arm64_linux:       "a56e692603298d329a7cdf2a36cb29916c4247693de27a4421d3a8d199ba1eb9"
    sha256 cellar: :any, x86_64_linux:      "f67c8c4de92fe3a13145b911e4aef476249757c1c99f4891713ef486571f05f7"
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
