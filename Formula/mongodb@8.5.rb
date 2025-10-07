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
    sha256 cellar: :any,                 arm64_tahoe:   "72bc645857e15d036555f07654a0ef9fd443ab41a3d106f4d22ec2e602fb4242"
    sha256 cellar: :any,                 arm64_sequoia: "835a4172811c46b490ab3e81f657519bd09026c7ce5d97f88f64c28c16715228"
    sha256 cellar: :any,                 arm64_sonoma:  "a61f934326a93331d477cdd7af27819b2c4468017d5e582c6586dc636e7f9e15"
    sha256 cellar: :any,                 sonoma:        "9e8a46d2c1bb5f60a7677f4bd20643ad8cd7f37ac33b540e2d446051c19f50b8"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "5528ebcfa58204cb70aec50b2dbcaa43fbdf8fbcc6a6a46a01f62740302af534"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1eaff9dff72747dfd9fc5ff7975c2eb8f139844eda4617d844dd210c759ae2fe"
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
