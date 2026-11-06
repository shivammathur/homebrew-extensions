# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT85 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_golden_gate: "e5cca102ab41e8704256c3238bca2c5aba12af1dbb1fe68e8c76b21de55ef934"
    sha256 cellar: :any, arm64_tahoe:       "41e6f7eba30ba5e584bebd72b904778c06ef9ec9c6411dbda234bcc27baea12d"
    sha256 cellar: :any, arm64_sequoia:     "310abfe07bff64c1ffeb130de949664cbcdb3c80d1c8f6c6bd829f367124d80e"
    sha256 cellar: :any, arm64_linux:       "c0b74f4d6e25328e253db24414acc92f3e70c82f8e5ef31032021fa8dc16fbe5"
    sha256 cellar: :any, x86_64_linux:      "95f8cec3785e501a1f8b9051deb7f9974221f4c4b2ff6a09a65cb7673fadd130"
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
