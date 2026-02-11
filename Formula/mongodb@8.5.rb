# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT85 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "15380592e1bbb83d72dfca990346229eac7e39f1cfd5b3e55bd6f4c318f3d048"
    sha256 cellar: :any,                 arm64_sequoia: "b360d7752c87023eabb2a92e86437c75bb1682b420a55a606053d045fa656fda"
    sha256 cellar: :any,                 arm64_sonoma:  "10745dc4a194bc227a31cebd0edf5166d4b2f6e4a53a4efc71a0cb9444543a83"
    sha256 cellar: :any,                 sonoma:        "7fdf025aa97fa66c9937fcacc0c66c320f8738f17880f02d46f7bc25ec78be6b"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "230545d67dc5aa822617c7526ca46cec7ad6ba17a42f47444718834fbf3d5db3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "0c64bc44856f50a56a855cd771865997c0d63e8e8dd21a9ed9bbbd1b8e074eb2"
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
