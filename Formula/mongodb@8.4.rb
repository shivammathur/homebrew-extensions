# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT84 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-2.1.4.tgz"
  sha256 "a5d09090fec30f1a8c26d0ea2f2b36583e1a2ca2b74754a3aad9753193a2a5e1"
  revision 1
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v2.x"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "441dba5a901cae1eebe63a634a8f99b11582e94f8de34c474377a4993b00f497"
    sha256 cellar: :any,                 arm64_sequoia: "13ed611a480b4c3afc0b74c44d104dd40e028e80a28f979f2db5bcb8d468c066"
    sha256 cellar: :any,                 arm64_sonoma:  "50dab48f2be1eb03669707aaeae988300f1230c96741bd9e25d24c5bea406ca8"
    sha256 cellar: :any,                 sonoma:        "aeb119e304526a1326f94cf3ebd3837154b3630fba2e44f52d75861e5122416a"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "1802e55e019dde1ef9e27302bcfc7fdbe27aec3b8c9594291caf395f9e4f8493"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "9f3804379d73dc062e557989380d64341df058898a79dbdeeb0d38c709a7ed27"
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
