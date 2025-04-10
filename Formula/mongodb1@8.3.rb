# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class Mongodb1AT83 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.21.0.tgz"
  sha256 "336506cfd52a878c29bf7e9fb99ff70054ab5efef19ab063c2d28e3889fdb557"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(1\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "673edf506f4e32b6ebb5a5bbb7189391cb85895c41ed24d51585cfa57ffd5d16"
    sha256 cellar: :any,                 arm64_sonoma:  "51f53ecde33900b1f80d6f4662428143880b83ece8401350395a287ac0fd0947"
    sha256 cellar: :any,                 arm64_ventura: "18c58d76be68dbeca8ef8cfa2427da8724176a5bb1ac27fae4b01edac5478c8e"
    sha256 cellar: :any,                 ventura:       "56ba0c4f23615617dc16ec2c3737b6b09a7408b12eff8bf1ffe6824339d972b8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "dd9775e9dbc351737ceee4b001237d5242a507a8780b922537a4e2cd85fcf8b1"
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
    prefix.install "modules/mongodb.so"
    write_config_file
    add_include_files
  end
end
