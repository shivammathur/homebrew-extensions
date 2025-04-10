# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT85 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-2.0.0.tgz"
  sha256 "6a53987a5e75fc65d032ac93cc8d4522a5cd06e068828e6b6e12612597fc88df"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v2.x"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "2851096093a11b1b5290f1ecfd6f6cf5dd089acb9e2c19144f4538cec1e271c9"
    sha256 cellar: :any,                 arm64_sonoma:  "02e1a4e2819ea350be5f6c7862be2a41c39b23502c54569969abbef3e99e2b6f"
    sha256 cellar: :any,                 arm64_ventura: "c107111168c6f317d9cc015ab9770f15ed80f254c3ff3672e424b94a4f913a91"
    sha256 cellar: :any,                 ventura:       "d4bb92e5ebf307a1520270a93e38e5b6ff66262b68947bdca258bc043515562f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "cdb18ff918e2f4fe3c9a5fa52614b45ecb4cace39baa7ae3cface556b4d000b4"
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
