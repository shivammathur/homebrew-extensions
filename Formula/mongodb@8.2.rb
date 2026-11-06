# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT82 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-2.5.7.tgz"
  sha256 "078773856f4066b56738fc13950bb7ee16b5e66f727fb41d3fbec6043c78fd32"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v2.x"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "860ddd83b3b7be85bb86ab244b1b900bd361edc0c9e849b4728632ecca82c4bb"
    sha256 cellar: :any, arm64_tahoe:       "05aca16c10af8da6ee3c9e73e8016633e329c58f28d06274fc44f1fff0746a1f"
    sha256 cellar: :any, arm64_sequoia:     "9ccec025ef72daa871d04e6dd4c69bfa7934c1baf2d58b936ce97d769f745d3b"
    sha256 cellar: :any, arm64_linux:       "0e75db021b25d6ddbd8c79d340195c3387417ba3b2005277230131ad10fb462f"
    sha256 cellar: :any, x86_64_linux:      "cfe8f56601343eec422eec9018ee5a50ff093cc6b7126e77fc907da5ef02d338"
  end

  depends_on "cyrus-sasl"
  depends_on "icu4c@78"
  depends_on "openssl@4"
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
