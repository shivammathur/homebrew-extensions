# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class Mongodb1AT82 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.21.5.tgz"
  sha256 "b542e9285308dcd16ad4277f62a94cca2910ee57616a5a4f576ff686f3da4c77"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v1.21"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(1\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "2532a817138e2968e8bffbd3cafbc55bf729a5e1e1dea664b7efd10816a852ef"
    sha256 cellar: :any,                 arm64_sequoia: "48162b7f6974c0f7aa0247147b7a4b3a66d563bc93f37a573d3a4bbd2bc97ef7"
    sha256 cellar: :any,                 arm64_sonoma:  "9b8ad985ac3656d03eae3bfdd3257514af7cc4f2dd0f54d5008bff4a7404cd51"
    sha256 cellar: :any,                 sonoma:        "c50d98711a4be4a04c4c2760f9988e2da2396239c11922b24c997ea147d8c920"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "56371ff6b40948e097dec025b6739fcbf5caae349deb6573575b87cb7bb1083a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f22878304dc92d93940cb7e4cf5825bb5b619c562669edc843e63ad33bca2487"
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
    prefix.install "modules/mongodb.so"
    write_config_file
    add_include_files
  end
end
