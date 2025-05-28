# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class Mongodb1AT85 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.21.0.tgz"
  sha256 "336506cfd52a878c29bf7e9fb99ff70054ab5efef19ab063c2d28e3889fdb557"
  license "Apache-2.0"
  revision 1

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(1\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "ca14df73092af47bb0f1f4feec50e393300808b70f7966079ae0985d20075494"
    sha256 cellar: :any,                 arm64_sonoma:  "88dad1350a9e48e7146cc137c5aab7073b646edf6f50dacc69762eeb2981f7b1"
    sha256 cellar: :any,                 arm64_ventura: "664043c5b21e7bad48566821f20c2a048f63348e76b8849816c9c2c3ba8b6ac4"
    sha256 cellar: :any,                 ventura:       "83f1da495fa9379c352490167a7b4a977cdcde6e4919dd5f3248138d65f8142a"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "bec2173ff990ddefa5ca0e512206e4bd3575e8eeb01dc128775d08a5eef6df22"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "5fbfa76cd06858099eb1a83e0bf701273392d70ba6af7e0551dd30b689f4eb46"
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
