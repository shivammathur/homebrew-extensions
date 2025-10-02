# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT81 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "e59f711974f072fdad7a3fe6e58a01d8608c2bc7f6c547b0d8fc4ff88552fbf5"
    sha256 cellar: :any,                 arm64_sequoia: "7cd5e621c84c7328734df7509d86c98b9ebb08a1fef3efe3eefd9fb237a6a7e5"
    sha256 cellar: :any,                 arm64_sonoma:  "2d62ae368cad1ac67b8d8740fe22240b96238cd4245bda6ab0f5c64bb86682dc"
    sha256 cellar: :any,                 sonoma:        "4b10ceccd1d86d55882a2e67dbbe1778b107e2e0869d6649f25c895ad7d5f613"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "133991357bbd9e30cca63eefe60635e9d7a91429226bcc2ea5b4dd8aea0bff1c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "447e808b4f6765512276c3fda66f906c2c869221f265abe02357e760c43496ff"
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
