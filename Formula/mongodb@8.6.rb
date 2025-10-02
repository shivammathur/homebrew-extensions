# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT86 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "bb45942416810289d1d7427c3fb4b291f96d070c9f7f153152c72561baaf53d7"
    sha256 cellar: :any,                 arm64_sequoia: "3fbdaa773c3469976c84f474442466ecba7284d1a165104fdbdb338ab8ec3f3a"
    sha256 cellar: :any,                 arm64_sonoma:  "10d0c26f3ee9deade4779cfec8be238c5d49ceba2e4d1c80edaf4d2740310209"
    sha256 cellar: :any,                 sonoma:        "67b13f4e1038a4fe1e3888a15b35c5be9600d9a928e8a0d57fc23f32c28416d8"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "10333d35df6c1125c7e2336fbcb9dbf0686e6c63cdd951ec31e9f75ca359952f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "17db32498523ee5cad96b6043d29121d53820da5066b7e14348a69912a35f649"
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
    inreplace "src/MongoDB/ServerApi.c", "ZVAL_IS_NULL", "Z_ISNULL"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-mongodb"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
