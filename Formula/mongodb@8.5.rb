# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT85 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "a2504bc41a59468506c1f94e2235ef1160f0d46a5bf71ac821bd85e4093cfc14"
    sha256 cellar: :any,                 arm64_sequoia: "df5909e9c641820c1d96d5605dd10d191a16f1f919bb5bd98dd97e8671c3bef1"
    sha256 cellar: :any,                 arm64_sonoma:  "cac6fbbd0aa675b7723a4a1d3f0b77dcf264bed77bd52ec69ba51159b8079c28"
    sha256 cellar: :any,                 sonoma:        "4842cd86b0964f611e437e3495a9750a1aa8e50621aae07bceeefbe6b17dc670"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "81f645566b84cd09684031d2556c9ad447cd8005ccdd3005dbf5bdf4d706ff7f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "bbeee03d4ac4e1b4fdc573648a6e5177702bdba3b1c5273c1a51be95d1e0c396"
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
