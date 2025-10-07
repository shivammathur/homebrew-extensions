# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT85 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "ab3278193abe07140649038b61570c84fd0d0fe8770e48b7f3e9f3e4286b3ea2"
    sha256 cellar: :any,                 arm64_sequoia: "0d8b48f2bec48c72a5f88769c41479faaa8a10e4495fc3cca0d0a675055b41b0"
    sha256 cellar: :any,                 arm64_sonoma:  "d78058c7c950acf6c4fb066ac0ed84926f29ff6597104e29c8a6701743aba163"
    sha256 cellar: :any,                 sonoma:        "6e1d6f9602b1766555b9debd3c169f4d1025ea28b1ab6c9dcec8154acf3e3d83"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "797a9988cb08458bc07962f54660b92f9f172a1a87f416a966898ecc7fcfe6f3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "30d69be833a8e797939b0a641c7d01ba426c24a4115c069a2d74522ea90edcca"
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
