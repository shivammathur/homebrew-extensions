# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT82 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-2.2.1.tgz"
  sha256 "b923617bec3cde420d80bf78aeb05002be3c0e930b93adaacaa5c2e0c25adb42"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v2.x"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "fa37ffd2b10f39b1cd2d505eea0b379705e1ded25240c1919f5db136ea9f2caf"
    sha256 cellar: :any,                 arm64_sequoia: "d51e2238c12e79d17458104f9a3ae58b60ab3e502daf111ab2a347a249168ba7"
    sha256 cellar: :any,                 arm64_sonoma:  "063e202163573e86a84c336565cd961edb352bf0e045c46137758c8959fd751b"
    sha256 cellar: :any,                 sonoma:        "f9ffbcd0a45e39d70e459be700d5747acb32eeffaf458b2dcfa67dec24fbaadc"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "dac32723eb74392aa564222a24c8b7671f6e272e56f49958eb7eeee81f1c7d0f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "24a418c7a097dc5b02df4fe2ebff79b80ecdba4f811f531ee7f710536949865b"
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
