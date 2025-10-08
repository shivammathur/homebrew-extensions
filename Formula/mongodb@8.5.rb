# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT85 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-2.1.4.tgz"
  sha256 "a5d09090fec30f1a8c26d0ea2f2b36583e1a2ca2b74754a3aad9753193a2a5e1"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v2.x"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "e72f1c62b18ea2b755d7694fe2b73ceb24dca642bbf83223c212fad11815b9b3"
    sha256 cellar: :any,                 arm64_sequoia: "ef8d49512d37beb6aceb010e2b0e9020aff48e8cbac73ebb81aee96af6186865"
    sha256 cellar: :any,                 arm64_sonoma:  "75784aebbd99a5c96e0c2382fb6cd40b969eaa6c9542182228b7967c3ab2622f"
    sha256 cellar: :any,                 sonoma:        "1cbe9b0548c7e591cff80c85361c26dae6963916a1df0b489adc3c1aada66f5c"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "1927fb4fcea91b610299fa6e682188bb28bcd49dec6a2ef72885d546c2542569"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1c324abaf0b4de330c90565942e3ee9bfafa1a291fcb8c4380d446854f877223"
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
