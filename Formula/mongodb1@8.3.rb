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
  revision 1

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(1\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "3677feb69334be1aad5671c1c06f2bcf69608b4fa21af8b291ca950b7df02476"
    sha256 cellar: :any,                 arm64_sonoma:  "fb97b1bbe50c1181faa915f171c004dd59e24f3b75ea3729355a211f412328ca"
    sha256 cellar: :any,                 arm64_ventura: "99d2699081e8c2c305e1200fd724728807c1b2a3d43e11b4dced354607c34e34"
    sha256 cellar: :any,                 ventura:       "ad80e48405510b925173d36ccebf49bc5eaf837bc45de4899553ddfda2975ad4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e6ad05625b23398f3a3d4d774489d1fa31bd18c9e5a687cc8779fc9d1797b2b0"
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
