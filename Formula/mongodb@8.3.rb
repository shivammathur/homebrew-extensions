# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT83 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-2.1.3.tgz"
  sha256 "6ef901d143a739c0769fad5b1bcd92646baa094d532e43738b48a13039ab067c"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v2.x"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "f51317fc96848a595152536c679ecfadbab61e4d844a876d67a63d3846162f52"
    sha256 cellar: :any,                 arm64_sequoia: "6710920911045bbcc580de4cf749d823a7be0528cef84f80891e91f243990756"
    sha256 cellar: :any,                 arm64_sonoma:  "a1f6db10e1a19d9a67059794033106ae33a607c96cc17b1bf93b189707055c09"
    sha256 cellar: :any,                 sonoma:        "21b82f5e1175bccff94a456771018f56c2581f0c6502cf4080f1bb3ee4dee95c"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "b5380a0799a58fd425a90cc68326f8eb93993cc7bd806bfcbb1b634ad0d96d1e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d171b575111b5982a7c56d6b6d947d75183dcbce3008bba802861a8b26c06a2f"
  end

  depends_on "cyrus-sasl"
  depends_on "icu4c@77"
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
