# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class Mongodb1AT82 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.21.7.tgz"
  sha256 "e4e30d82639d698a174356193f7ff33b101523d16ae769faf66fbb217dfb36c4"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v1.21"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(1\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "b7bc1f4e341c4165ac67db05c14da519126ec620879b219900d6b1555d1f8fdf"
    sha256 cellar: :any, arm64_sequoia: "62af37209f7eba08f857b57872ee22fac429c65d1962bb599d8cb2649612efa2"
    sha256 cellar: :any, arm64_sonoma:  "1168a57c1f2462b54e3d6574a1ad950093cf6186615cc68d3ff34ec084c24562"
    sha256 cellar: :any, sonoma:        "24a418915e9b9570ee9abce261ea1eee5931edecb138e2b541f3838fe78e10b1"
    sha256 cellar: :any, arm64_linux:   "d6977d4bdf24d20c05730ac66fb6a4cd80144e928c28d91929a05895b8b03984"
    sha256 cellar: :any, x86_64_linux:  "8837addb1eb7e317f364eddb5d1fe8515539b437e607585ec7fcf0a5d00bab34"
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
    prefix.install "modules/mongodb.so"
    write_config_file
    add_include_files
  end
end
