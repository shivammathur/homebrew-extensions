# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT85 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-2.3.1.tgz"
  sha256 "2738972432d36c370fde3c76c208c31bd5a7a0afc4a7705874f92f322f3d2786"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v2.x"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "a030315d2745906e938f47071a4ef8d97ae6426dd1d06dea3d9ddc9ce9f749ca"
    sha256 cellar: :any,                 arm64_sequoia: "a1f6dea7b6091f788708f634de93fef94b5c48745acc3d84c1a0f5031ae32acf"
    sha256 cellar: :any,                 arm64_sonoma:  "6e931394b99bc44daac50b70c8df599efc6f2d8e748f5fa7c7f4f02651eb50b0"
    sha256 cellar: :any,                 sonoma:        "2538662c2ca894f798ce4d20a1fa4d03eae6328542aa9bfcd36d37b833e67107"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "8793ea06c9b3ef4f4d722e2fa7f6318ee46b728f606494ce864f03284162ec9b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1fb5616d7d3a139347c4465ddc78343ca52d135d625e5e6012f09ff21bc33dc4"
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
