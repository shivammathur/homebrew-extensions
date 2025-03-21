# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT83 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia: "ffbfd0735a548fada8e6c5eaa4bece0d132e044cd9fbde6cdbc0b5bbe899a9c8"
    sha256 cellar: :any,                 arm64_sonoma:  "e20a2a01ad62d2aa650ce83f3c6e0526723acc8f6c851467f507e223bc9f8e7f"
    sha256 cellar: :any,                 arm64_ventura: "98b7c56db26026c16d6321e952c79572c3d5190f4eaeac71796ff40ddaf08bb0"
    sha256 cellar: :any,                 ventura:       "03d47ac11591bdc0f8f3ea87269bc7556963fc7beab35f551c845ad2f566763a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "97b7f7c810d4cf7648801f65aecbcd14acbfb425be76afd6f0b6dbba0d572f52"
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
