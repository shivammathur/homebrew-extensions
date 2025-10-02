# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT83 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-2.1.2.tgz"
  sha256 "01892642ba68f762b5a646f7e830d693e163a32b7e78c16e616df72c56ce3d2d"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v2.x"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "374869391cffe1ab5bff034b93249f99182b723badd97cfa1b95478d26242c0a"
    sha256 cellar: :any,                 arm64_sequoia: "c279b38baae6ead0ff97767db73178656cfb94b884b8991144b222424b633b1d"
    sha256 cellar: :any,                 arm64_sonoma:  "2502ef518e87cb5d5fa4366caffc8045ddf31e109ff9ae0f2c77cafd2a77d8e1"
    sha256 cellar: :any,                 sonoma:        "35425bf22d09d8f4a96e08fcecf04678afcc52a4bb9e7c16d1f970daa5bfe420"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "02b8b8c8ef2c179c4591ce8ac42779414b5c58d2c10c967b72cdae397a0fc85b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "bcdd1b42d0bf9f9a4568ee49a2211f99e9db455223af2d528892b2747377fdce"
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
