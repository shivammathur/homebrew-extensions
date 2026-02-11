# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT84 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-2.2.0.tgz"
  sha256 "02b0fc089176a1cc2133b5e12aba72bff103154d2ead4789749a99c1b47f8223"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v2.x"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "a24b7cd695ca4ddbc94f5c0e23de46ceecdb3ad4efb447a55eeed3d07ea6f371"
    sha256 cellar: :any,                 arm64_sequoia: "61cdba4c71bcb56dd24e1ef1a5244b8543c43ac1264fe38193bd1e4e5e2039de"
    sha256 cellar: :any,                 arm64_sonoma:  "e2f02a043e9a539e65bdceb0f4ad2219b572450fd8b9775ade111bbf9babee21"
    sha256 cellar: :any,                 sonoma:        "5fcd836c657499a57c148e304df1cdeb6c169160eca8f5664065adf181442f8b"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "3646e778cb8a9611aad415d1421c1b5adffdd1bf825e1ec8b1d481bbd2d5355f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "523aff181be500ceaa54ec281514518ad6c91cd2a762e0e2bb3dd6f4d96185d9"
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
