# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT83 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-2.5.0.tgz"
  sha256 "532b8408978a3b7a0aa4abdd7b33699ccbf94c312e7fce38da408b787006c08f"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v2.x"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "ed64ae416c225b644d5d70116e661fccb7f0d23793ce4d2678db673a0db99b4a"
    sha256 cellar: :any, arm64_sequoia: "cadb93fe9e2d360e3dd1bcb5d74d006fa86e1e0ad669a7d174d0c82d1637798c"
    sha256 cellar: :any, arm64_sonoma:  "5680de5e5c19cbf1e8cd6cc50c7633738370cb3c686978a0a536aac89ac1b3ee"
    sha256 cellar: :any, sonoma:        "2817f08215915c930478f7b8d15d8a35674a740149e6a47a47541a5f880d1ed8"
    sha256 cellar: :any, arm64_linux:   "9303d36ac611f0953dbcf3470f77307c509aadfe50825bb99e352eda2bf47ec0"
    sha256 cellar: :any, x86_64_linux:  "19c89efe9f88528e7a137ae1e1d5d433febf85a6114e2291eeb6adc6fc3510b1"
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
