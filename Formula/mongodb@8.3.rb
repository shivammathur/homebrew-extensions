# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT83 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "64d852b312ef528220c6d7a6f9b79240c46c10516cd462b4413ae67eb122a1ee"
    sha256 cellar: :any,                 arm64_sequoia: "ab664275cf0c9016d1d157bf161dab68af10a249c3f8e389a11043a87384c8e4"
    sha256 cellar: :any,                 arm64_sonoma:  "88564d2384c4f5cc2de293a1c2b8b53717c9b6b2b1a567270529ec102388b972"
    sha256 cellar: :any,                 sonoma:        "180c3bb5396659ee0bdaeca79e34563acc4e225e3eca029773994c72332956c8"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "f65747ba87f1a899c873de0cd389d04c268af6b0a7dd51e285089fa6e6972e8a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "da66008cec22d2ccdba4285e86272eed929130728a7f78cd89f230d2a8399b6b"
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
