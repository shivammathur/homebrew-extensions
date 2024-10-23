# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT72 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.16.2.tgz"
  sha256 "d630cf32a73b6e5e05d2806782d35e06d24b7d5c83cfec08239549e6b6a600b2"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v1.16"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 4
    sha256 cellar: :any,                 arm64_sequoia: "3a07a6dc74405caf3689d4775ae2083fca951399216bcc19c4726138fd8f9d34"
    sha256 cellar: :any,                 arm64_sonoma:  "78a987cfa18b8690ac8b127a7eb9678d77ec60f7acbc1a984aa3eb0edec38370"
    sha256 cellar: :any,                 arm64_ventura: "fc6db81bae49697346378deb557587801d1ff684cdbe180406b5505234bb368b"
    sha256 cellar: :any,                 ventura:       "4280716eea4998f2fe30441774611f50cf8f434127f185a6f18995ed7f5106f8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "de1b5548df2d3fab37834bd21b12c505555fa87e7c2ee8f02227e9d2a8ff4f28"
  end

  depends_on "icu4c@75"
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
