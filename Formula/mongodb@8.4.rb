# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT84 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "c668fcdbf57e59342e414babd7a5a6a38c01bc9ae5eaf08d8bd52e8f5f91c9c4"
    sha256 cellar: :any,                 arm64_sequoia: "bc14f24663fe701561456200b210666315b027b3cadfddbd3aa13285880b72d1"
    sha256 cellar: :any,                 arm64_sonoma:  "cd98a9cc3a3411595fc1845ff76af1933c361834a0f6b181d810f2e10f022336"
    sha256 cellar: :any,                 sonoma:        "2ad4f13f3cff08f75e5c95647a476af9dc9c2c6b8fdef87fd6b307f7d63cd3bb"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "9a898eec2cd2c3861bddaf21c5d16dc77e46892771b7f8200d341dc2410f8d12"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a470246c9f3fb19405ba52fdd20c78081c97b404d51eda27a5363b14ac05e949"
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
