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
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "8755c235a2cefcda7cd2808882a622cbeba419a643f2e3f4429f08a533f5644c"
    sha256 cellar: :any,                 arm64_sonoma:  "29df4f68046d01b8857aaa605043c88465896f4de607cf54f6f165d0e18d70d4"
    sha256 cellar: :any,                 arm64_ventura: "892272f47b1b28c138193a31d057e83ec2b0e1674587447cf6248ad8632baea9"
    sha256 cellar: :any,                 ventura:       "18d772cc34cc5f766b449c6041670c575b8761013a34e51d53154d7fce908531"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f50966450bbae7b144d835d92c8a3d24de9a8e104e1ad402e19addf7e226389d"
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
