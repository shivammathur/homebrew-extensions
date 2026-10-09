# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT85 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_golden_gate: "d15c3f9656a905ae292cfd1e49a07257790dd6283379ff8351c5ff7065665427"
    sha256 cellar: :any, arm64_tahoe:       "79ddcac83fb87544840938641e93038008ccaa2691a57cb6d4202d958a482458"
    sha256 cellar: :any, arm64_sequoia:     "dc8141fd2842f7fb88f61433835641425552751ee3d76962cca11f7654a36955"
    sha256 cellar: :any, arm64_linux:       "a27e5f551182bc231ee05c017e9c40c57147c1e282c4ed33c37def086dbcae25"
    sha256 cellar: :any, x86_64_linux:      "f9766d0543f61f1f82fcad21d91dd00c90caa2a2220cd0642c821e4a79406d07"
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
