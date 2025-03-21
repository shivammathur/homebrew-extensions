# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT81 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.21.0.tgz"
  sha256 "336506cfd52a878c29bf7e9fb99ff70054ab5efef19ab063c2d28e3889fdb557"
  revision 1
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v1.x"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "1d63aa8ad90a391cea000d3412cb013b28398be42e46577613c53beeb07cbe79"
    sha256 cellar: :any,                 arm64_sonoma:  "51c544fa0c6a31d33170f7fa99ab2dd184ed871849390827bb9f84c87640aa98"
    sha256 cellar: :any,                 arm64_ventura: "56e7fc5b943ed0ef10dcb97ebec7a94a64f26efae3b0fb8c54857f26441c4f40"
    sha256 cellar: :any,                 ventura:       "1452755baea84bd869e2169e82569910b6476fc8fb2dd027e2c8382012e92b1f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "5ae0d7ae1b246ddc2299fc12f2de467b638bd406000fb2b6bae329e0651d73c2"
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
