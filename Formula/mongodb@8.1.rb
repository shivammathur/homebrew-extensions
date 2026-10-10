# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT81 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-2.5.4.tgz"
  sha256 "41eead0799cc66876b12d10b5efe86268bfc704c1be57a70d49e4bd4bf6c8ee1"
  revision 1
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v2.x"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "8473e9fa8fed012642f13b3f20089972dad1788c612ef0c34cf8ba4599af9cae"
    sha256 cellar: :any, arm64_tahoe:       "bf117fce5859c97150d49954599141716f551dc8477ad54cdd91f51728596177"
    sha256 cellar: :any, arm64_sequoia:     "8fc67c1b6532c7aa339088a671291bc1f9ad76e3d7bcb80c4c0092bc196a630a"
    sha256 cellar: :any, arm64_linux:       "37d50fd28afa686f351034d7e6ae59ac6a486ad287da905c72a961c25dd83a71"
    sha256 cellar: :any, x86_64_linux:      "a97d8ccf9766e65face7cc7419a21df0e08a2ff78b837f5ef039ac71a8b788c8"
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
