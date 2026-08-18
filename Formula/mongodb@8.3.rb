# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT83 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-2.4.0.tgz"
  sha256 "08d0d298f0e4c6190a4f8c1f1e23cfbf5d64a1063370b35368bd53012025afa8"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v2.x"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "130bb6fbd542c29f5c2eb8af1255cb9feb00d7fc07dc3e4a37f1fb0d9dda46d4"
    sha256 cellar: :any, arm64_sequoia: "dc0bc0f281cbf38c1f7e4f422b2c8a9515a04398d3e68e03053c4c998885572e"
    sha256 cellar: :any, arm64_sonoma:  "880c3a1922017223da857665bb01407168ede177a3c6b4132421ee7b2e2f1357"
    sha256 cellar: :any, sonoma:        "85a964b2c8f91cb63c7de20cd15ee97a90285f2df32dc5739a620245c30d272a"
    sha256 cellar: :any, arm64_linux:   "9b12eea75fe773cf0540a3e3ab8e63723feda10c2e2808eecde0df49d08489c6"
    sha256 cellar: :any, x86_64_linux:  "a57847122da7be72ee7e0aefc90146c7f5e28bf9ea0e57906d089d9d0a4f4cb4"
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
