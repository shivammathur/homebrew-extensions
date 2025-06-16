# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT81 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-2.1.1.tgz"
  sha256 "bea8eb86be7e301b1cd3935ee3ccfa052e410a7cfa404ae5ab4b11e4c99b8899"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v2.x"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "9b3f7530c371369d9d9653a5f2972f02d2f9a3eb11a3807e6332bea811d5da6e"
    sha256 cellar: :any,                 arm64_sonoma:  "88fb3f90603bf574bca0cb6b5eafee3e65b9811823d2f1f414edb93d30127247"
    sha256 cellar: :any,                 arm64_ventura: "f713a98e51073fc4c1453ac9b6442c9a078e4e466f026f93520b356cf3216ed4"
    sha256 cellar: :any,                 ventura:       "eee3910a40b63397a3d993fb7b3efde848381dcd0796f65fc9622274f9eaab31"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "47603be3491207742b8004b1c63dc60dd7c642ee3981d2fb4cc2d427c0a9c558"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "fc622154412878ba82c36b4786b4df3b33293aa1c7519788ba6b845606f181ed"
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
