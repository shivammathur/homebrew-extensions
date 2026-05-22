# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT85 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "3d92026445cb5bb447f2b9da6c6b7104a936fe0ec6b08881694bbdfb6e4fce08"
    sha256 cellar: :any,                 arm64_sequoia: "49b72847f8e6a621af9ed40f3db8bd46da004b0c0744c1faf473adaa39bf58c7"
    sha256 cellar: :any,                 arm64_sonoma:  "561a729515f3ba1fe934b3690fd81b7f0a8c729d76141b6078f165c206b581f8"
    sha256 cellar: :any,                 sonoma:        "3cb57baaf96b043ede94c8246af826da8e4b81433def964a7bf373a6786bb8f8"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "f1726fa485a5c0ce73901812bfb13f6d1455ad1c7fd21d54decc3fa9b64cdcaa"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "9289f3de8a874aff91f5aab0d453b34926933f34527cb45efab194c543f9d189"
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
