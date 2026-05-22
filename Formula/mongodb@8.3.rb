# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT83 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "1df9e57a6f6720918e046ccd3e0273e3a6da7a7d62c0518b89c2c630a2ba5559"
    sha256 cellar: :any,                 arm64_sequoia: "69da4c2bdbd1279ddeda2d43a98f62c100c87c1295edaff408c3d94299a7ffae"
    sha256 cellar: :any,                 arm64_sonoma:  "b907878399b91ae0ad854db9eae6d4f30bc5af120053bf025fc6aaa0dc8c36b7"
    sha256 cellar: :any,                 sonoma:        "5c95209c5b32802daaea2b64019a5c1a36a84f210d501129658c65570a9ca8ae"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "3ffdda2706c5e3f0cdd5e8f0f84b78ecf199b45501f72234382ea6ede7dc2b99"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "5e090cc346a862e7a3d2baf0fac87b93f4f53999ece037695daf8823738fcac4"
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
