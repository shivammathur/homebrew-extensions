# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT84 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "43cb89e57eefd8d859e0f0bf9beb6516534204ef25f0eda9f6f920a456ac67e9"
    sha256 cellar: :any,                 arm64_sequoia: "833c371600914ad8d4931bb546466a4d7761a7b24ed11b77430f30ac9532b9ea"
    sha256 cellar: :any,                 arm64_sonoma:  "b0f560fc1bbcbcb451a002798f42d5ccbea178d6a210a5f855f27fa169797af9"
    sha256 cellar: :any,                 sonoma:        "d16de86b573f135ff41b78765f27054f9addfbd9895527668c2983afd0199a18"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "1a48edaba525e4defe8a139513a3a9eec095f6a0cc921ab677e20e51c9660e43"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b87978b400c725363952592afcee485bccbc45abdd47ef667e9508d682ce674e"
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
