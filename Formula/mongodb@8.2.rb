# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT82 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "da2bba260ea3cf9ee37e5a9b13bf1f637230e05523d65b4c271619c82431d399"
    sha256 cellar: :any,                 arm64_sequoia: "b32aa0376a3f3fe379e94bd8909e73a2ad1e83ed256a32b62eec5e2e25cdc9db"
    sha256 cellar: :any,                 arm64_sonoma:  "99ddb055eb509b191a9320e09fb7927bbcbb23b72c96f7fc2f80e5476dd0e804"
    sha256 cellar: :any,                 sonoma:        "a5d4e1335e9c3d98e1ce45a32aab8c9f1082b546b5527d6ec2467b05bde64d6c"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "d59af52282a38d9ecce31daac1ef6efd23db576ae50fab1230ea296fcb891f03"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "bdd729b6db84ee83a28a5c9597301451b449a87aa627466c69b8dbbb91737201"
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
