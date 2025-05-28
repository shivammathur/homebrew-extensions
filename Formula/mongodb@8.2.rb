# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT82 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-2.1.0.tgz"
  sha256 "2717abd81cdff4a1ed1f08d9f77d9c3601a9d934e89bc5441617f7c0acd62d17"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v2.x"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "3df398623ef1076bd585821413190d6bf04dda752bd8b7fd0b88cb01b93e63c5"
    sha256 cellar: :any,                 arm64_sonoma:  "9f4e50edd6c054706e82aa212885376bde177a79260dcf15f4c7dc8a8a212128"
    sha256 cellar: :any,                 arm64_ventura: "655926a90c25d699705ff1c8b38c0e943f38c0a9099472967aea5d0a6f8904aa"
    sha256 cellar: :any,                 ventura:       "ff12d83c3d59ffa80068e66503bcc00a6a9238869bf98d89a1595b5bd93b2e2f"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "27ede701f8e801a6609471ff8a7f455f888d4c492b2d04b861d09bbe1cce8b8a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "71a078712b1174378927587f0ae9c2b5518688002ea2e89cec17f48ad779d9fe"
  end

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
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-mongodb"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
