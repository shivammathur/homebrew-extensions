# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT85 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-2.5.3.tgz"
  sha256 "5e5369cd01b47543fb3244917eff17fa4c8c357b0866828d59c899b4e53e6665"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v2.x"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "41f3ca0b9d6640ffa41779c94d2abfba176f0a8758fca6f335f3203745d3636c"
    sha256 cellar: :any, arm64_tahoe:       "c698c6a407a216c04fb662e073999cf1475f3987476e4a1706f7d95abb6f288e"
    sha256 cellar: :any, arm64_sequoia:     "b72bbe0711f8e939960d6815096bddf3344dc634e784b751f08b9bc71c96a3c7"
    sha256 cellar: :any, arm64_linux:       "01cf78ab025c05707413359254604fcdf05c80e873a5b32f00828053e26bc8e3"
    sha256 cellar: :any, x86_64_linux:      "e5bd80a7f2aab7f23762526b9d93a8d3deff416847b7f374c9c33e9a9ba13d34"
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
