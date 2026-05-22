# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT82 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-2.3.3.tgz"
  sha256 "370ff9c06932139c69f6b4c57b1a97c95b0278d3baf23fa42b8fb571ddb92bbf"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v2.x"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "40d48c8dc24345f40bd1f345422db8b2cfd96d2df4511cfdde3106cf0d8d3938"
    sha256 cellar: :any,                 arm64_sequoia: "5b6f043a6c6185ffbbf272d3395f56e861bb856026fca2edd210e4a50d8718ae"
    sha256 cellar: :any,                 arm64_sonoma:  "494b419dcfea294341ce84f7bfccd94caa999f34a6532fd948ee406cb961ce6a"
    sha256 cellar: :any,                 sonoma:        "dfe65725096ac62c7a720bba87ffb6f75cd6f0e122c81d2fd8256407df57759f"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "12bc2d9a9f33cb97496c0bdeae9a22defb26eed227db7e8c9da5451ea89fa3c0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "65921bd6f90c87eb5263ad121c7292bd39864816a7b805cc00051faf9144faac"
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
