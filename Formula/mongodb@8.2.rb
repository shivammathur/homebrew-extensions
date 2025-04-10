# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT82 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-2.0.0.tgz"
  sha256 "6a53987a5e75fc65d032ac93cc8d4522a5cd06e068828e6b6e12612597fc88df"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v1.x"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "aacb9efbcff0264ae85a4e3f19d2996635bd06346361ef4574b65b9953cf43d5"
    sha256 cellar: :any,                 arm64_sonoma:  "964a5f9379f33d8372f4a93d7098acc055c6e56e7f51815a84d74a0bbfac83a4"
    sha256 cellar: :any,                 arm64_ventura: "b6e3aed158939e98333c2c8401ef43dd6e98216e84d90d83993509fb6b203c88"
    sha256 cellar: :any,                 ventura:       "11c7f9fe4c5b331ceb4e05c9ab6ac893616a5b4f2fb21b458c1f619c6bfc4171"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f63dce8617c7e2528783d75af384b2d5398df49d81902919c21e5ad5fee796d7"
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
